extends Node2D

onready var idle = get_node("Idle")
onready var bater = get_node("Batendo")
onready var anim = get_node("Anim")
onready var grave = get_node("Grave")
var lado
const ESQ = -1
const DIR = 1

func _ready():
	# Called every time the node is added to the scene.
	# Initialization here
	pass
func irEsqerda():
	set_pos(Vector2(220, 1070))
	idle.set_flip_h(false)
	bater.set_flip_h(false)
	grave.set_pos(Vector2(-44, 41))
	grave.set_flip_h(true)
	lado = ESQ

func irDireita():
	set_pos(Vector2(500, 1070))
	idle.set_flip_h(true)
	bater.set_flip_h(true)
	grave.set_pos(Vector2(28, 41))
	grave.set_flip_h(false)
	lado = DIR
	
func bater():
	anim.play("Bater")
	
func morrer():
	anim.stop()
	idle.hide()
	bater.hide()
	grave.show()
	
