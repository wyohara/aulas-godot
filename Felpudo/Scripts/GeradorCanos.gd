extends Position2D

#somente quando for carregado o cano a var cano fica disponibilizado
onready var cano  = preload("res://Cenas/Cano.tscn")

func _ready():
	randomize()

#no de conexao entre timer e gerador quando expira o tempo
func _on_Timer_timeout():
	var novoCano = cano.instance()
	novoCano.set_pos(get_pos() + Vector2(0, rand_range(500, -500)))
	get_owner().add_child(novoCano)