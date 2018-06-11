extends Node2D
func _ready():
	pass
func destruir(sentido):
	if(sentido == -1):
		get_node("Anim").play("animDir")
	else:
		get_node("Anim").play("animEsq")
	