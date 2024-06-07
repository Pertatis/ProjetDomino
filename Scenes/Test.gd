extends Node2D

var regle_inst:PackedScene = preload("res://Scenes/Règle.tscn")

const distance_domino = 47


var base:Array
var objectif:Array
var regles:Array
var test

func _ready():
	test = Global.current_level
	creer_niveau()

func creer_niveau():
	base = Global.current_level["Base"].duplicate()
	objectif = Global.current_level["Obj"].duplicate()
	regles = Global.current_level["Reg"].duplicate()
	var instance
	supprimer_tout()
	#Ajoute la base
	for domino in test["Base"]:
		instance = Global.get_domino(self,domino)
		instance.position = $Background/Base/BasePoint.position + (Vector2.RIGHT * distance_domino * ($Background/Base.get_child_count() - 1))
		$Background/Base.add_child(instance)

	#Ajoute l'objectif
	for domino in test["Obj"]:
		instance = Global.get_domino(self,domino)
		instance.position = $Background/Objectif/ObjectifPoint.position + (Vector2.RIGHT * distance_domino * ($Background/Objectif.get_child_count() - 1))
		$Background/Objectif.add_child(instance)
	
	#Ajoute les regles
	
	# Chaque regle
	for regle in test["Reg"]:
		#Instancie la scène de la regle (signaux + position)
		var instance_regle = regle_inst.instance()
		instance_regle.disconnect_signals()
		instance_regle.position = $Background/PaletteRegles/ReglePoint.position + (Vector2.DOWN * 60 * ($Background/PaletteRegles.get_child_count() - 1))
		#recupère les enfants de la scene pour avoir coté droit et gauche
		var sous_regle = instance_regle.get_children()[0].get_children()
		#cote gauche
		for domino in regle[0]:
			instance = Global.get_domino(null,domino)
			instance.position = sous_regle[1].get_children()[1].position + (Vector2.RIGHT * 10 * (sous_regle[1].get_child_count() - 2))
			instance.scale = Vector2(0.15,0.15)
			sous_regle[1].add_child(instance)
		#cote droit
		for domino in regle[1]:
			instance = Global.get_domino(null,domino)
			instance.position = sous_regle[3].get_children()[1].position + (Vector2.RIGHT * 10 * (sous_regle[3].get_child_count() - 2))
			instance.scale = Vector2(0.15,0.15)
			sous_regle[3].add_child(instance)

		$Background/PaletteRegles.add_child(instance_regle)
		

func supprimer_tout():
		#Supprime les dominos existants
	for child in $Background/Base.get_children():
		if not (child is Position2D):
			$Background/Base.remove_child(child)
	
	for child in $Background/Objectif.get_children():
		if not (child is Position2D):
			$Background/Objectif.remove_child(child)
			
	for child in $Background/PaletteRegles.get_children():
		if not (child is Position2D):
			$Background/PaletteRegles.remove_child(child)

func _on_Editer_pressed():
	var error = get_tree().change_scene("res://Scenes/Edition.tscn")
	if error != OK :
			print("Failed to change scene", error)


func select_domino_handle(id):
	print(id)
