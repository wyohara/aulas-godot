extends Node

var score1 = 0
var score2 = 0
var spinner1_ok = false
var spinner2_ok = false
var resetando = false
var time
signal block
signal unblock

func _ready():
	# Called every time the node is added to the scene.
	# Initialization here
	pass
	
func atualizaScore():
	get_node("Control/Player1/Score").set_text(str(score1))
	get_node("Control/Player2/Score").set_text(str(score2))
	emit_signal("block")
	spinner2_ok = false
	spinner1_ok = false

func _on_Spinner2_limit():
	score2 += 1
	atualizaScore()
	get_node("Control/Player1/Msg").set_text(str("Você perdeu"))
	get_node("Control/Player2/Msg").set_text(str("Você Venceu"))
	
func _on_Spinner1_limit():
	score1 +=2
	atualizaScore()
	get_node("Control/Player2/Msg").set_text(str("Você perdeu"))
	get_node("Control/Player1/Msg").set_text(str("Você Venceu"))

func _on_Spinner2_zero():
	spinner2_ok = true
	if spinner2_ok:
		reset()
		
func _on_Spinner1_zero():
	spinner1_ok = true
	if spinner1_ok: 
		reset()
	
func reset():
	if resetando : return
	resetando = true
	
	get_node("Control/Player1/Msg").set_text(str(""))
	get_node("Control/Player2/Msg").set_text(str(""))
	time = 5
	get_node("EntreRound").start()

func _on_Entre_node_timeout():
	time -=1
	if time>1:	
		get_node("Control/Player1/Msg").set_text(str(time))
		get_node("Control/Player2/Msg").set_text(str(time))
	if time ==1:
		get_node("Control/Player1/Msg").set_text("Go")
		get_node("Control/Player2/Msg").set_text("Go")
		resetando = false
		emit_signal("unblock")
	if time == 0:
		
		get_node("Control/Player1/Msg").set_text("")
		get_node("Control/Player2/Msg").set_text("")
		