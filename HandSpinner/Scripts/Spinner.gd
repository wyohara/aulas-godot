extends Node2D

var vel = 0
var acel = -2 #aceleração que reduz a velocidade conforme o tempo
var block = false

signal speed(valor) #sinal de vlocidade para a speedbar
signal limit
signal zero

func _ready():
	set_process(true)

func _process(delta):
	if vel > 1:
		vel += acel * delta
	else:
		vel = 0
		acel = -2
		if block:
			emit_signal("zero")
			
	emit_signal("speed",vel/50)
	get_node("Corpo").set_rot(get_node("Corpo").get_rot() + delta*vel)

func _on_Contato_input_event( viewport, event, shape_idx ):
	if event.type == InputEvent.SCREEN_TOUCH and event.pressed and not block:
		vel += 5
	if vel > 50:
		vel = 50
		emit_signal("limit")

func _on_BtnBack_pressed():
	get_node("Corpo/Sprite").set_texture(load("res://assets/black_ready.png"))


func _on_BtnRed_pressed():
	get_node("Corpo/Sprite").set_texture(load("res://assets/red_ready.png"))


func _on_BtnYellow_pressed():
	get_node("Corpo/Sprite").set_texture(load("res://assets/yellow_ready.png"))



func _on_Spinner1_speed( valor ):
	pass # replace with function body


func _on_Spinner_speed( valor ):
	pass # replace with function body


func _on_Game_block():
	block = true
	acel = -10

func _on_Game_unblock():
	block = false
