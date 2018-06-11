extends Node2D

onready var marc = get_node("Vida")
var totalVida = 1

signal vidaZerado

func _ready():
	set_process(true)
	
func _process(delta):
	if totalVida>0 : # caso ainda tenha vida ela é reduzido com o tempo
		totalVida -= 0.08*delta
		marc.set_region_rect(Rect2(0,0, totalVida*188, 23))
		marc.set_pos(Vector2(-(1-totalVida) *188/2, 0))
	else:
		emit_signal("vidaZerado")
		
func addVida(vida):
	totalVida += vida
	if totalVida>1: 
		totalVida = 1