extends Node2D

var regle_inst:PackedScene = preload("res://Scenes/Règle.tscn")

const distance_domino = 47


var base:Array
var objectif:Array
var regles:Array
var test

var selected_dominos:Array
var selected_dominos_type:Array

func _ready():
	test = Global.level2
	creer_niveau()
	var nikmok = [1,2,3,4,5]
	print(nikmok)
	nikmok.insert(1,99)
	print(nikmok)

func creer_niveau():
	base = test["Base"].duplicate()
	objectif = test["Obj"].duplicate()
	regles = test["Reg"].duplicate()
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
		instance_regle.connect("regle_clicked",self,"click_on_regle")
#		instance.disconnect("gui_input",instance,"_on_ColorRect_gui_input")
		instance_regle.position = $Background/PaletteRegles/ReglePoint.position + (Vector2.DOWN * 60 * ($Background/PaletteRegles.get_child_count() - 1))
		#recupère les enfants de la scene pour avoir coté droit et gauche
		var sous_regle = instance_regle.get_children()[0].get_children()
		#cote gauche
		for domino in regle[0]:
			instance = Global.get_domino(null,domino)
			if instance != null:
				instance.position = sous_regle[1].get_children()[1].position + (Vector2.RIGHT * 10 * (sous_regle[1].get_child_count() - 2))
				instance.scale = Vector2(0.15,0.15)
				sous_regle[1].add_child(instance)
#			else:
#				instance_regle.selected = true
		#cote droit
		for domino in regle[1]:
			instance = Global.get_domino(null,domino)
			if instance != null:
				instance.position = sous_regle[3].get_children()[1].position + (Vector2.RIGHT * 10 * (sous_regle[3].get_child_count() - 2))
				instance.scale = Vector2(0.15,0.15)
				sous_regle[3].add_child(instance)
#			else:
#				instance_regle.selected = true
		$Background/PaletteRegles.add_child(instance_regle)
#
	for regle in regles:
		if (regle[0] == [''] or regle[1] == ['']):
			light_up_regle(regles.find(regle))


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

func select_domino_handle(id):
	# si n'existe pas, le rajoute
	if not selected_dominos.has(id):
		selected_dominos.append(id)
		selected_dominos.sort()
		# rajoute tous les autres dominos si on sélectionne des dominos non contigues
		for i in range(selected_dominos[0] + 1,selected_dominos[selected_dominos.size() - 1]):
			if not selected_dominos.has(i):
				selected_dominos.append(i)
	else:
		if id == selected_dominos[0] or id == selected_dominos[selected_dominos.size() - 1]:
			selected_dominos.erase(id)
		else:
			# supprimer de id -> fin
			for i in range(id,selected_dominos[selected_dominos.size() - 1] + 1):
				selected_dominos.erase(i)
	
	selected_dominos.sort()

#
	regler_taille_domino()
	get_dominos_color()
	compare_regles()
func get_dominos_color():
	selected_dominos_type = []
	var children = $Background/Base.get_children()
	for element in selected_dominos:
		selected_dominos_type.append(Global.get_color(children[element].filename))
	
func compare_regles():
	for regle in regles:
		if selected_dominos_type == regle[0] or selected_dominos_type == regle[1] or ((regle[0] == [''] or regle[1] == ['']) and selected_dominos.size() <= 1):
#		if selected_dominos_type == regle[0] or selected_dominos_type == regle[1]:
		
			light_up_regle(regles.find(regle))
		else:
			darken_regle(regles.find(regle))


func light_up_regle(number):
	var regle = $Background/PaletteRegles.get_children()[number + 1]
	regle.get_children()[0].color = Color.beige
	regle.selected = true
	
func darken_regle(number):
	var regle = $Background/PaletteRegles.get_children()[number + 1]
	regle.get_children()[0].color = Color.white
	regle.selected = false

#recherche la regle, et vérifie si elle est selectionné (la base l'équivaut à la regle)-
func click_on_regle(id):
	var regle = $Background/PaletteRegles.get_children()[id]
	var regle_actuelle = regles[id - 1]
	var domino_inserer
	var where_to_add = 0
	
	if regle.selected:
		if (regle_actuelle[0] != [''] or regle_actuelle[1] != ['']) and \
		 (selected_dominos_type == regle_actuelle[0] or selected_dominos_type == regle_actuelle[1]):
			
			#Verifie si le nombre de dominos maximum n'est pas dépassé
			if not si_nombre_domino_max(regle_actuelle):
				selected_dominos.clear()
				selected_dominos_type.clear()
				compare_regles()
				regler_taille_domino()
				return
			# Remove selected dominos
			for i in selected_dominos.size():
				base.remove(selected_dominos[0] - 1)
			
			# Determine which side is selected and insert the other side
			if regle_actuelle[0] == selected_dominos_type:
				domino_inserer = regle_actuelle[1].duplicate()
			elif regle_actuelle[1] == selected_dominos_type:
				domino_inserer = regle_actuelle[0].duplicate()
			
			if domino_inserer:
				domino_inserer.invert()
				for element in domino_inserer:
					base.insert(selected_dominos[0] - 1, element)
		
		elif selected_dominos.size() <= 1:
			# Determine where to add the new dominos
			if not selected_dominos.empty():
				where_to_add = selected_dominos[0]
			
			if regle_actuelle[0] == [''] and regle_actuelle[1].size() + base.size() <= 15:
				domino_inserer = regle_actuelle[1].duplicate()
			elif regle_actuelle[1] == [''] and regle_actuelle[0].size() + base.size() <= 15:
				domino_inserer = regle_actuelle[0].duplicate()
			
			if domino_inserer:
				domino_inserer.invert()
				for element in domino_inserer:
					base.insert(where_to_add, element)
	
	# Reset selection
	selected_dominos.clear()
	selected_dominos_type.clear()
	
	compare_regles()
	
	# Remove non-Position2D children from Base
	for child in $Background/Base.get_children():
		if not (child is Position2D):
			$Background/Base.remove_child(child)
	
	# Draw the dominos
	var instance
	for domino in base:
		instance = Global.get_domino(self, domino)
		if instance:
			instance.position = $Background/Base/BasePoint.position + (Vector2.RIGHT * distance_domino * ($Background/Base.get_child_count() - 1))
			$Background/Base.add_child(instance)
	
	base = Global.remove_whitespace(base)
	print(base)


func _on_Reinitialiser_pressed():
	creer_niveau()

func si_nombre_domino_max(regle):
	var tmp
	if regle[0] == selected_dominos_type:
#		print(base.size() - regle[0].size() + regle[1].size())
		return base.size() - regle[0].size() + regle[1].size() <= 15
	else:
		return (base.size() - regle[1].size() + regle[0].size() <= 15)
		
func regler_taille_domino():
	var all_dominos = $Background/Base.get_children()
	# Assigner la taille adéquate aux dominos
	for element in all_dominos:
		if not (element is Position2D):
			if (element.get_index() in selected_dominos):
				element.scale = Vector2(0.88,0.88)
			else:
				element.scale = Vector2(0.8,0.8)
