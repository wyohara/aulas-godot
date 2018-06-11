extends RigidBody2D

onready var cena = get_tree().get_current_scene();

func _ready(): #metodo quando o passaro é criado
	set_process_input(true) #permite que o objeto receba input
	
func _input(event):
	if(event.is_action_pressed("touch") and cena.estado == cena.JOGANDO):
		aplicar_forca()
		get_node("somVoar").play()
		
func aplicar_forca():
	apply_impulse(Vector2(0,0), Vector2(0, -1000))
