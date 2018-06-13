extends RigidBody2D

onready var sprite = get_node("Sprite")
onready var shape = get_node("Shape")
onready var anim = get_node("Anim")

signal signalErrou
var isCortada = false

func _ready():
	set_process(true)
	randomize()

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
		anim.play("Explode") #executa a animação explode
		emit_signal("signalErrou")