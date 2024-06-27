extends Node

const SAVE_DIR = "user://saves/"
const SAVE_EXTENSION = ".save"

var domino_blue:PackedScene = preload("res://Scenes/Domino/DominoPalette/DominoPaletteBleu.tscn")
var domino_red:PackedScene = preload("res://Scenes/Domino/DominoPalette/DominoPaletteRouge.tscn")
var domino_green:PackedScene = preload("res://Scenes/Domino/DominoPalette/DominoPaletteVert.tscn")
var pinkfloyd:PackedScene = preload("res://Scenes/Domino/DominoPalette/DominoPaletteRose.tscn")
var domino_yellow:PackedScene = preload("res://Scenes/Domino/DominoPalette/DominoPaletteJaune.tscn")

var regle_inst:PackedScene = preload("res://Scenes/Règle.tscn")

var levels_created:Array

var current_level:Dictionary

var level1:Dictionary
var level2:Dictionary

var save_nbr: int = 0
# Liste pour stocker les noms de fichiers
var save_files = []

func _ready():
	
	count_saves()
	list_saves()
	make_level1()
	make_level2()

func list_saves():
	save_files = []
	
	var dir = Directory.new()
	
	if dir.open(SAVE_DIR) == OK:
		dir.list_dir_begin()
		var file_name = dir.get_next()
		
		while file_name != "":
			if dir.current_is_dir() == false and file_name.ends_with(SAVE_EXTENSION):
				save_files.append(file_name.rsplit(".save")[0])

			file_name = dir.get_next()
		dir.list_dir_end()
	else:
		print("Failed to open save directory")
	
	# Afficher les fichiers de sauvegarde
#	for save_file in save_files:
#		print(save_file)

func load_game(file_name):
	var file_path = SAVE_DIR + file_name + SAVE_EXTENSION
	var file = File.new()
	var err = file.open(file_path, File.READ)
	if err == OK:
		var save_data = file.get_var()
		file.close()
		print("Level loaded from slot", save_data)
		# Tu peux ajouter du code ici pour utiliser les données de sauvegarde
		return save_data
	else:
		print("Failed to load level:", err)
		print("File path:", file_path)
		
		for level in levels_created:
			if level["Name"] == file_name:
				return level

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
		if node != null:
			if node.name == "Fond":
				inst.connect("supp_domino_bleu",node,"supp_domino_handle")
			elif node.name == "Resolution" or node.name == "Test":
				inst.connect("select_domino_bleu",node,"select_domino_handle")
		return inst
		
	if "R" in color:
		var inst = domino_red.instance()
		if node != null:
			if node.name == "Fond":
				inst.connect("supp_domino_rouge",node,"supp_domino_handle")
			elif node.name == "Resolution" or node.name == "Test":
				inst.connect("select_domino_rouge",node,"select_domino_handle")
		return inst
		
	if "G" in color:
		var inst =  domino_green.instance()
		if node != null:
			if node.name == "Fond":
				inst.connect("supp_domino_vert",node,"supp_domino_handle")
			elif node.name == "Resolution" or node.name == "Test":
				inst.connect("select_domino_vert",node,"select_domino_handle")
		return inst
		
	if "Y" in color:
		var inst =  domino_yellow.instance()
		if node != null:
			if node.name == "Fond":
				inst.connect("supp_domino_jaune",node,"supp_domino_handle")
			elif node.name == "Resolution" or node.name == "Test":
				inst.connect("select_domino_jaune",node,"select_domino_handle")
		return inst
		
	if "P" in color:
		var inst = pinkfloyd.instance()
		if node != null:
			if node.name == "Fond":
				inst.connect("supp_domino_rose",node,"supp_domino_handle")
			elif node.name == "Resolution" or node.name == "Test":
				inst.connect("select_domino_rose",node,"select_domino_handle")
		return inst
	return null


func get_rond_color(color):
	if "B" in color:
		return  Color( 0.160784, 0.235294, 0.882353, 1 )
	if "R" in color:
		return Color( 1, 0.00392157, 0.00392157, 1 )
	if "G" in color:
		return Color( 0.0705882, 0.823529, 0.0980392, 1 )
	if "Y" in color:
		return Color( 1, 0.780392, 0, 1 )
	if "P" in color:
		return Color( 1, 0.188235, 0.627451, 1 )
		

func make_level1():
	var one = ['B','R','R','Y','B','R','Y','Y','R']
	var two = ['R','Y']
	var regles:Array = []
	var temp = []
	
	temp.append(Array(['R','B']))
	temp.append(Array(['B','R']))
	
	regles.append(temp)
	temp = []
	temp.append(Array(['Y','R','Y']))
	temp.append(Array(['Y','R']))
	
	regles.append(temp)
	temp = []
	temp.append(Array(['Y','Y']))
	temp.append(Array(['']))
	
	regles.append(temp)
	level1["Base"]=one.duplicate()
	level1["Obj"]=two.duplicate()
	level1["Reg"]=regles.duplicate()
	level1["Name"] = "Level 1"
	
	levels_created.append(level1.duplicate()) 
	
	return level1
	
func make_level2():
	var one = ['B','R','G','R','G','G','G','B','G']
	var two = ['B','G']
	var regles:Array = []
	var temp = []
	
	temp.append(Array(['G','B','G']))
	temp.append(Array(['B','G']))
	regles.append(temp)
	
	temp = []
	temp.append(Array(['G','R']))
	temp.append(Array(['R','G']))
	regles.append(temp)
	
	temp = []
	temp.append(Array(['G','G']))
	temp.append(Array(['G']))
	regles.append(temp)
	
	temp = []
	temp.append(Array(['R','R']))
	temp.append(Array(['']))
	regles.append(temp)
	
	temp = []
	temp.append(Array(['B','B']))
	temp.append(Array(['B']))
	regles.append(temp)
	
	level2["Base"]=one.duplicate()
	level2["Obj"]=two.duplicate()
	level2["Reg"]=regles.duplicate()
	level2["Name"] = "Level 2"
	levels_created.append(level2.duplicate())
	
	return level2
	
func remove_whitespace(arr):
	var new_arr = []
	for item in arr:
		if item.strip_edges() != "":
			new_arr.append(item)
	return new_arr


func count_saves():
	var dir = Directory.new()
	if dir.open(SAVE_DIR) == OK:
		dir.list_dir_begin()
		var file_name = dir.get_next()
		while file_name != "":
			if file_name.ends_with(SAVE_EXTENSION):
				save_nbr += 1
			file_name = dir.get_next()
		dir.list_dir_end()
	else:
		print("Failed to open save directory")
