extends Node2D

onready var felpudo = get_node("Felpudo")
onready var timeReplay = get_node("tempoRejogar")
onready var contarPontos = get_node("DadosGame/Controle/Pontuacao")
var pontos = 0
var estado = 1

const JOGANDO = 1
const PERDEU = 2

func _ready():
	# Called every time the node is added to the scene.
	# Initialization here
	pass
	
func endGame():
	#recuando o felpudo
	felpudo.apply_impulse(Vector2 (0,0), Vector2(-1000, 0))
	get_node("AnimationFundo").stop()
	estado = PERDEU
	timeReplay.start() #inicia o tempo
	get_node("somMorte").play()
	
func _on_tempoRejogar_timeout():
	get_tree().reload_current_scene() #reiniciar a cena

func pontuar():
	pontos += 1
	contarPontos.set_text(str(pontos))
	get_node("somPonto").play()