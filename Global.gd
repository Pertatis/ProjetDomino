extends Node

var domino_blue:PackedScene = preload("res://Scenes/Domino/DominoPalette/DominoPaletteBleu.tscn")
var domino_red:PackedScene = preload("res://Scenes/Domino/DominoPalette/DominoPaletteRouge.tscn")
var domino_green:PackedScene = preload("res://Scenes/Domino/DominoPalette/DominoPaletteVert.tscn")
var pinkfloyd:PackedScene = preload("res://Scenes/Domino/DominoPalette/DominoPaletteRose.tscn")
var domino_yellow:PackedScene = preload("res://Scenes/Domino/DominoPalette/DominoPaletteJaune.tscn")

var regle_inst:PackedScene = preload("res://Scenes/Règle.tscn")

var levels_created:Array

var level1:Dictionary

func _ready():
	make_level1()

func get_color(filename):
	if "Bleu" in filename:
		return 'B'
	if "Rouge" in filename:
		return 'R'
	if "Vert" in filename:
		return 'G'
	if "Jaune" in filename:
		return 'Y'
	if "Rose" in filename:
		return "P"
		

#Fonction qui prend un char et renvoie l'instance du domino correspondant
func get_domino(node,color):
	if "B" in color:
		var inst = domino_blue.instance() 
		inst.connect("supp_domino_bleu",node,"supp_domino_handle")
		return inst
		
	if "R" in color:
		var inst = domino_red.instance()
		inst.connect("supp_domino_rouge",node,"supp_domino_handle")
		return inst
		
	if "G" in color:
		var inst =  domino_green.instance()
		inst.connect("supp_domino_vert",node,"supp_domino_handle")
		return inst
		
	if "Y" in color:
		var inst =  domino_yellow.instance()
		inst.connect("supp_domino_jaune",node,"supp_domino_handle")
		return inst
		
	if "P" in color:
		var inst = pinkfloyd.instance()
		inst.connect("supp_domino_rose",node,"supp_domino_handle")
		return inst

func make_level1():
	var one = ['B','R','G','Y','P']
	var two = ['P','Y']
	var regles:Array = []
	var temp = []
	
	temp.append(Array(['R','B']))
	temp.append(Array(['B','R']))
	
	regles.append(temp)
	level1["Base"]=one
	level1["Obj"]=two
	level1["Reg"]=regles
	
	
