extends Node2D

onready var timerCorte = get_node("IntervaloRaycast")
onready var timerLimiteCorte = get_node("LimiteCorte")

var pressionado = false #flag para pressionado
var drag = false #flag para arrastando
var posInicial = Vector2(0,0)
var pos = Vector2(0,0)
var jogando = true #flag para parar o corte

func _ready():
	set_process_input(true) #ativado a leitura de imput
	set_fixed_process(true)#listener alinhado com a biblioteca de fisica
	
func _fixed_process(delta):
	update()
	if drag and posInicial != Vector2(0,0) and pos != posInicial and jogando: 
		var espaco = get_world_2d().get_direct_space_state() #cria o raycast
		var resultado = espaco.intersect_ray(posInicial, pos) #retorna objetos que estão no caminho
		if not resultado.empty(): #caso exista fruta
			resultado.collider.cortarFruta()
			
func acabou(): #metodo para encerrar o jogo
	jogando = false

func _input(event):
	event = make_input_local(event) #ajjusta a ca captura de eventos para local
	if event.type == InputEvent.SCREEN_TOUCH: #caso detectar um toque na tela 
		if event.pressed: #caso seja pressionado somente
			telaPressionada(event.pos) 
		else: #caso solte a tela
			soltarTela()
	if event.type == InputEvent.SCREEN_DRAG: #caso arraste na tela
		arrastarTela(event.pos)

func telaPressionada(posicao):
	pressionado = true #ativa a flag de pressionado
	posInicial = posicao #degfine a posicao inicial
	timerCorte.start() #inicia o timer
	timerLimiteCorte.start() #inicia o timer

func soltarTela():
	pressionado = false #tira a flag de pressionar
	drag = false #tira a flag de arrastar
	timerLimiteCorte.stop() #para timer
	timerCorte.stop()
	pos = Vector2(0,0) #zera pos
	posInicial = Vector2(0,0)
	
func arrastarTela(posicao):
	pos = posicao
	pressionado = true #inicia a flag de pressionado
	drag = true #inicia a flag drag
	timerLimiteCorte.start() #inicia timer
	timerCorte.start()
	
func _on_IntevaloRaycast_timeout():
	posInicial = pos #atualiza a posição inicial
	
func _on_LimiteCorte_timeout():
	soltarTela() #quando o tempo de pressionado for zerado, inicia a ação de soltar
	
func _draw():	
	if drag == true and posInicial != Vector2(0,0) and pos != posInicial and jogando:  
		draw_line(posInicial, pos, Color(1,0,0), 10)