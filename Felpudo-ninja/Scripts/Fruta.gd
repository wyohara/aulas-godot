extends RigidBody2D

onready var shape = get_node("Shape")
onready var sprite0 = get_node("Sprite0")
onready var body1 = get_node("Body1")
onready var body2 = get_node("Body2")
onready var sprite1 = get_node("Body1/Sprite1")
onready var sprite2 = body2.get_node("Sprite2")

var isCortada = false

signal signalScore
signal signalErrou

func _ready():
	randomize() #ativa a aleatorização
	set_process(true)

func _process(delta):
	if get_pos().y > 800: #caso saia da tela é explodida
		emit_signal("signalErrou")
		queue_free()

func nascerFruta(posInicial):
	#Método responsavel por fazer nascer uma fruta no jogo
	#posInicial - recebe uma posição inicial aleatória 
	set_pos(posInicial) #setando a posição da fruta
	var velInicial = Vector2(0, rand_range(-1000, -800)) #impulso inicial
	if posInicial.x < 640: #caso fique a esquerda é jogada para direita
		velInicial = velInicial.rotated(deg2rad(rand_range(0, -30)))
	else: #caso contrário é jogado para a esquerda
		velInicial = velInicial.rotated(deg2rad(rand_range(0,-30)))
	set_linear_velocity(velInicial) #aplicando a velocidade
	set_angular_velocity(rand_range(-20, 20)) #faz a fruta girar no seu eixo
	
func cortarFruta():
	if !isCortada: #verifica se não está cortada
		isCortada = true
		set_mode(MODE_KINEMATIC) #tornando parado o objeto
		sprite0.queue_free() #remove a imagem da fruta inteira
		body1.set_mode(MODE_RIGID) #tira do modo estatico para rigido, assim poderão cair
		body2.set_mode(MODE_RIGID)
		body1.apply_impulse(Vector2(0,0), Vector2(-100, 0).rotated(get_rot())) #aplica força para separar a fruta e as rotaciona
		body2.apply_impulse(Vector2(0,0), Vector2(100, 0).rotated(get_rot()))
		body1.set_angular_velocity(get_angular_velocity()) #faz os pedaços de frutas girarem
		body2.set_angular_velocity(get_angular_velocity())
		emit_signal("signalScore")


func _on_TimerDestruir_timeout():
	#criando o timer para destruir a fruta após 3 segundos
	queue_free()
