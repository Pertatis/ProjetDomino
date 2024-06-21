extends Node2D

var regle_inst:PackedScene = preload("res://Scenes/Règle.tscn")
var numero_inst:PackedScene = preload("res://Scenes/Numero.tscn")
var historique_inst:PackedScene = preload("res://Scenes/Historique.tscn")
var rond_historique:PackedScene = preload("res://Scenes/RondHistorique.tscn")

const distance_domino = 50
const max_nb_domino = 14


var base:Array
var objectif:Array
var regles:Array
var test
var compteur_historique: int = 0

var historique:Array

var selected_dominos:Array
var selected_dominos_type:Array

func _ready():
	test = Global.level2
	creer_niveau()

func creer_niveau():
	print(test)
	base = test["Base"].duplicate()
	objectif = test["Obj"].duplicate()
	regles = test["Reg"].duplicate()
	var instance
	supprimer_tout()
	historique.clear()
	compteur_historique = 0
	#Ajoute la base
	for domino in test["Base"]:
		instance = Global.get_domino(self,domino)
		instance.position = $Background/Base/BasePoint.position + (Vector2.RIGHT * distance_domino * ($Background/Base.get_child_count() - 1))
		instance.scale = Vector2(0.7, 0.7)
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
		var button = instance_regle.get_node("SupprimerRegle")
		button.queue_free()
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

		#cote droit
		for domino in regle[1]:
			instance = Global.get_domino(null,domino)
			if instance != null:
				instance.position = sous_regle[3].get_children()[1].position + (Vector2.RIGHT * 10 * (sous_regle[3].get_child_count() - 2))
				instance.scale = Vector2(0.15,0.15)
				sous_regle[3].add_child(instance)

		$Background/PaletteRegles.add_child(instance_regle)
#
	for regle in regles:
		if (regle[0] == [''] or regle[1] == ['']):
			light_up_regle(regles.find(regle))
	
	# supprimer l'historique
	for child in $"%HistoriqueFond".get_children():
		if not (child is Position2D):
			child.queue_free()
			$"%HistoriqueFond".rect_min_size -= Vector2(0, 60)


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
			# supprimer debut -> id
			if (id - selected_dominos[0] <= int(selected_dominos.size() / 2) - 1):
				for i in range(selected_dominos[0], id + 1):
					selected_dominos.erase(i)
			# supprimer de id -> fin
			else :
				for i in range(id, selected_dominos[selected_dominos.size() - 1] + 1):
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
	var before_removing_base = base.duplicate()
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
					regler_taille_domino()
				add_element_to_history(before_removing_base.duplicate())
		
		elif selected_dominos.size() <= 1:
			# Determine where to add the new dominos
			if not selected_dominos.empty():
				where_to_add = selected_dominos[0]
			
			if regle_actuelle[0] == [''] and regle_actuelle[1].size() + base.size() <= max_nb_domino:
				domino_inserer = regle_actuelle[1].duplicate()
			elif regle_actuelle[1] == [''] and regle_actuelle[0].size() + base.size() <= max_nb_domino:
				domino_inserer = regle_actuelle[0].duplicate()
			
			if domino_inserer:
				domino_inserer.invert()
				for element in domino_inserer:
					base.insert(where_to_add, element)
					regler_taille_domino()
				add_element_to_history(before_removing_base.duplicate())
	
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
			instance.scale = Vector2(0.7, 0.7)
			$Background/Base.add_child(instance)
	
	base = Global.remove_whitespace(base)

func add_element_to_history(array):
	historique.push_front(Global.remove_whitespace(Array(array)))
	compteur_historique += 1
	
	var instance_hist = historique_inst.instance()
	
	ajouter_rond_historique(array,instance_hist)
	
	for element in $"%HistoriqueFond".get_children():
		if not (element is Position2D):
			element.position += Vector2.DOWN * 60 
	
	instance_hist.position = $"%HistoriquePoint".position
	
	var label = instance_hist.get_children()[0].get_children()[0].get_children()[0]
	label.text = str(compteur_historique)
	
	instance_hist.connect("ligne_historique_clicked",self,"ligne_historique_handle")
	$"%HistoriqueFond".add_child(instance_hist)
	
	# changement gui
	$"%HistoriqueFond".rect_min_size += Vector2(0, 60)
	

func _on_Reinitialiser_pressed():
	creer_niveau()

func si_nombre_domino_max(regle):
	if regle[0] == selected_dominos_type:
		return base.size() - regle[0].size() + regle[1].size() <= max_nb_domino
	else:
		return (base.size() - regle[1].size() + regle[0].size() <= max_nb_domino)
		
func regler_taille_domino():
	var all_dominos = $Background/Base.get_children()
	# Assigner la taille adéquate aux dominos
	for element in all_dominos:
		if not (element is Position2D):
			if (element.get_index() in selected_dominos):
				element.scale = Vector2(0.88,0.88)
			else:
				element.scale = Vector2(0.7,0.7)

func _on_Menu_pressed():
	var error = get_tree().change_scene("res://Scenes/Menus/MainMenu.tscn")
	if error != OK :
			print("Failed to change scene", error)

func ligne_historique_handle(index):
	#recupère la ligne de l'historique cliquée
	var ligne_historique = $"%HistoriqueFond".get_child(index)
	var label_ligne = ligne_historique.get_children()[0].get_children()[0].get_children()[0]
	#remettre le compteur à index - 1 
	compteur_historique = index - 1
	# mettre l'état courant à la ligne selectionné de l'historique
	base = historique[historique.size() - index].duplicate()
	base = Global.remove_whitespace(base)
	var instance
	#enlever les dominos
	for child in $Background/Base.get_children():
		if not (child is Position2D):
			$Background/Base.remove_child(child)
	#redessiner
	for domino in base:
		instance = Global.get_domino(self,domino)
		instance.position = $Background/Base/BasePoint.position + (Vector2.RIGHT * distance_domino * ($Background/Base.get_child_count() - 1))
		instance.scale = Vector2(0.7, 0.7)
		$Background/Base.add_child(instance)
	
	#supprime l'historique 
	for element in $"%HistoriqueFond".get_children():
		if not (element is Position2D):
			$"%HistoriqueFond".remove_child(element)
	

	#supprimer les lignes de l'historique de la variable
	for _i in range(historique.size() - index + 1):
		historique.pop_front()
		
	$"%HistoriqueFond".rect_min_size = Vector2(720,0)
	compteur_historique = 1
	print('------------------')
	print('------------------')
	print('------------------')
	
	#redessiner tout l'historique
	for element in historique:
		print(element)
		var instance_hist = historique_inst.instance()
	
		ajouter_rond_historique(element,instance_hist)
		
		for element_2 in $"%HistoriqueFond".get_children():
			if not (element_2 is Position2D):
				element_2.position += Vector2.DOWN * 60 
	
		instance_hist.position = $"%HistoriquePoint".position
		
		var label = instance_hist.get_children()[0].get_children()[0].get_children()[0]
		label.text = str(compteur_historique)
		
		compteur_historique += 1
		
		instance_hist.connect("ligne_historique_clicked",self,"ligne_historique_handle")
		$"%HistoriqueFond".add_child(instance_hist)
		
		$"%HistoriqueFond".rect_min_size += Vector2(0, 60)
	
	compteur_historique -= 1
	print(historique)
		
func ajouter_rond_historique(array,inst_historique):
	var position2d = inst_historique.get_children()[0].get_children()[1].get_children()[0]
	var instance_rond
	for element in array:
		instance_rond = rond_historique.instance()
		instance_rond.modulate = Global.get_rond_color(element)
		instance_rond.position = position2d.position + (Vector2.RIGHT * 35 * (position2d.get_parent().get_child_count() - 1))
#		print(instance_rond.position)
		position2d.get_parent().add_child(instance_rond)
