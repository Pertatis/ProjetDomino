extends Node

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
	
	
