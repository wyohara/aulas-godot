extends Node2D

export var speed = -150 #exporta para propriedades do godot
var cena

func _ready():
	set_process(true) #define um listener para ler o fps
	cena = get_tree().get_current_scene() #recupera a cena de jogo
	
func _process(delta): #calculando a variação de fps
	if(cena.estado == cena.JOGANDO):
		set_pos(get_pos() + Vector2(speed * delta, 0))
	
	#destroi o cano quando sai da tela
	if(get_pos().x < -100):
		print ("destruido")
		queue_free()


func _on_Area2D_body_enter( body ):
	#body = corpo qu e entrou
	if(body.get_name() == "Felpudo"):
		#caso o felpudo colida e lançado a função kill
		cena.endGame()

func _on_Area2D_2_body_enter( body ):
	cena.pontuar()
