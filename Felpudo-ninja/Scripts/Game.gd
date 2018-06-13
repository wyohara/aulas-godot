extends Node2D

onready var frutas = get_node("Frutas")
var orange = preload ("res://Scenes//Orange.tscn")
var pear = preload ("res://Scenes//Pear.tscn")
var tomato = preload ("res://Scenes//Tomato.tscn")
var watermelon = preload ("res://Scenes//Watermelon.tscn")
var bomba = preload ("res://Scenes//Bomba.tscn")

var score = 0
var life = 3

func _ready():
	randomize()

func _on_GeradorFrutas_timeout():
	if life == 0: #caso chegue a vida 0 sai do gerador de frutas
		print ("SAIU")
		get_node("GameOver").start()
		return false
		
	for i in range (1, rand_range(1, 4)): #sorteando o numero de frutas
		var type = int(rand_range(0, 6)) #definindo o tipo de fruta
		var fruta = orange.instance()
		#checando o tipo de fruta
		if type == 0: 
			fruta = orange.instance()
		elif type == 1:
			fruta = pear.instance()
		elif type == 2:
			fruta = tomato.instance()
		elif type == 3:
			fruta = watermelon.instance()
		elif type == 4:
			fruta = bomba.instance()
		frutas.add_child(fruta) #adicionando a lista de frutas
		fruta.nascerFruta(Vector2(rand_range(200, 1000), 800)) #sorteando a posição
		fruta.connect("signalErrou", self, "perderVida") #conectando a perder vida
		if(type != 4): #caso não seja bomba e conectado o sinal pontuar
			fruta.connect("signalScore", self, "pontuar")
			
func pontuar():
	if life == 0:
		return
	else:
		score += 1
		get_node("Control/Label").set_text(str(score))

func perderVida():
	life -= 1
	if life == 2:
		get_node("Control/Bomba3").set_modulate(Color(1,0,0))
	if life == 1:
		get_node("Control/Bomba2").set_modulate(Color(1,0,0))
		
	if life == 0:
		get_node("Control/Bomba1").set_modulate(Color(1,0,0))
		get_node("Input").acabou()
		print ("acabou o jogo")