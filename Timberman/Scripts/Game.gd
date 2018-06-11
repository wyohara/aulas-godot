extends Node
onready var felpudo = get_node("Felpudo")
onready var camera = get_node("Camera") #criado a camera para pegar o touch

var barril = preload("res://Cenas/Barril.tscn")
var inimDir = preload("res://Cenas/InimigoDir.tscn")
var inimEsq = preload("res://Cenas/InimigoEsq.tscn")

onready var barris = get_node("Barris")
onready var destrBarris = get_node("DestrBarris")
onready var barra = get_node("BarraVida")
onready var labelPontos = get_node("Control/Pontos")
var pontos = 0

var ultIni
const JOGANDO = 1
const PERDEU = 1
var estadoJogo = JOGANDO

func _ready():
	randomize()
	set_process_input(true)
	gerarBarrilInicial()
	barra.connect("vidaZerado", self,"morrer")

func _input(event):
	#sobrescreve o event para eventos realizados na Camera
	event = camera.make_input_local(event)
	#verifica se o evento foi toque na tela e foi pressionado
	if(event.type == InputEvent.SCREEN_TOUCH and event.pressed and estadoJogo == JOGANDO):
		#como a largura da camera por default é 720, 360 é o meio
		#ajusta o lado do felpudo
		if(event.pos.x <360):
			felpudo.irEsqerda()
		else:
			felpudo.irDireita()
		#apos ajustar o felpudo é chamado a ação de bater
		if(!verificarBatida()):
			felpudo.bater()
			var prim = barris.get_children()[0]
			prim.destruir(felpudo.lado)
			barris.remove_child(prim)
			destrBarris.add_child(prim)
			barrilAleatorio(Vector2(360, 1090 - 10*172))
			desceBarril()
			barra.addVida(0.05)
			pontos += 1
			labelPontos.set_text(str(pontos))
			
		else:#evento caso o personagem morra
			morrer()
		if(verificarBatida()):
			morrer()
		
func desceBarril():
	for b in barris.get_children():
		b.set_pos(b.get_pos() + Vector2(0, 172))
			
func barrilAleatorio(pos):
	var num = rand_range(0, 3)
	if(ultIni):
		num = 0
	gerarBarril(int (num), pos) 
	
		
func gerarBarril(tipo, pos):
	var novo
	if tipo == 0:
		novo = barril.instance()
		ultIni = false
	elif tipo == 1:
		novo = inimDir.instance()
		ultIni = true
		novo.add_to_group("barrilDireito")
	elif tipo == 2:
		ultIni = true
		novo = inimEsq.instance()
		novo.add_to_group("barrilEsquerdo")
		
	novo.set_pos(pos)
	barris.add_child(novo)
	
func gerarBarrilInicial():
	for i in range(0, 2):
		gerarBarril(0, Vector2(360, 1090 - i*172))
	for i in range(2, 10):
		barrilAleatorio(Vector2(360, 1090 - i*172))
		
func verificarBatida():
	var lado = felpudo.lado
	var primeiro = barris.get_children()[0]
	
	if(lado == felpudo.ESQ and primeiro.is_in_group("barrilEsquerdo")
	or lado == felpudo.DIR and primeiro.is_in_group("barrilDireito")):
		return true
	else:
		return false
		
func morrer():
	if(estadoJogo == JOGANDO):
		felpudo.morrer()
		barra.set_process(false)
		estadoJogo = PERDEU
		get_node("Timer").start()
		print("morreu")
	

func _on_Timer_timeout():
	get_tree().reload_current_scene()
