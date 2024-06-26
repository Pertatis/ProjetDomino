extends Node2D

# --------- Scenes ---------
var domino_blue:PackedScene = preload("res://Scenes/Domino/DominoPalette/DominoPaletteBleu.tscn")
var domino_red:PackedScene = preload("res://Scenes/Domino/DominoPalette/DominoPaletteRouge.tscn")
var domino_green:PackedScene = preload("res://Scenes/Domino/DominoPalette/DominoPaletteVert.tscn")
var pinkfloyd:PackedScene = preload("res://Scenes/Domino/DominoPalette/DominoPaletteRose.tscn")
var domino_yellow:PackedScene = preload("res://Scenes/Domino/DominoPalette/DominoPaletteJaune.tscn")

var regle_inst:PackedScene = preload("res://Scenes/Règle.tscn")

# --------- Signals ---------
signal base_activer(index_regle)

# --------- Constants ---------
const max_nb_domino = 13
const max_nb_regles = 8
const max_nb_domino_par_cote_regle = 4
const distance_domino = 47

const MAX_SAVES = 10
const SAVE_DIR = "user://saves/"
const SAVE_EXTENSION = ".save"

# --------- Variables ---------
var regle_select:int = -1
var base:bool = false
var objectif:bool = false
var test

var base_dominos:Array
var objectif_dominos:Array


# --------- Select base ---------
func _ready():
	$LoadMenu.hide()
	base = true
	$"%PanelBase".color = Color.gainsboro
	if not Global.current_level.empty():
		# TEMPORAIRE NE DOIT PAS FAIRE CA
		test = Global.current_level
		remplir_niveau()

# --------- Signal handlers palette ---------
func _on_DominoPaletteBleu_click_domino_bleu():
	var instance_bleu = domino_blue.instance()
	instance_bleu.connect("supp_domino_bleu",self,"supp_domino_handle")
	if base :
		if $"%PanelBase".get_child_count() - 1 < max_nb_domino :
#			instance_bleu.scale = Vector2(0.5 , 0.5)
			instance_bleu.position = $"%BasePoint".position + (Vector2.RIGHT * distance_domino * ($"%PanelBase".get_child_count() - 1))
			$"%PanelBase".add_child(instance_bleu)
			base_dominos.append(Global.get_color(instance_bleu.filename))
	elif objectif :
		if $"%PanelObjectif".get_child_count() - 1 < max_nb_domino :
			instance_bleu.position = $"%ObjectifPoint".position + (Vector2.RIGHT * distance_domino * ($"%PanelObjectif".get_child_count() - 1))
			$"%PanelObjectif".add_child(instance_bleu)
			objectif_dominos.append(Global.get_color(instance_bleu.filename))
	elif regle_select != -1:
		ajouter_a_regle(instance_bleu)

func _on_DominoPaletteRouge_click_domino_rouge():
	var instance_rouge = domino_red.instance()
	instance_rouge.connect("supp_domino_rouge",self,"supp_domino_handle")
	if base :
		if $"%PanelBase".get_child_count() - 1 < max_nb_domino :
			instance_rouge.position = $"%BasePoint".position + (Vector2.RIGHT * distance_domino * ($"%PanelBase".get_child_count() - 1))
			$"%PanelBase".add_child(instance_rouge)
			base_dominos.append(Global.get_color(instance_rouge.filename))
	elif objectif :
		if $"%PanelObjectif".get_child_count() - 1 < max_nb_domino :
			instance_rouge.position = $"%ObjectifPoint".position + (Vector2.RIGHT * distance_domino * ($"%PanelObjectif".get_child_count() - 1))
			$"%PanelObjectif".add_child(instance_rouge)
			objectif_dominos.append(Global.get_color(instance_rouge.filename))
	elif regle_select != -1:
		ajouter_a_regle(instance_rouge)

func _on_DominoPaletteVert_click_domino_vert():
	var instance_vert = domino_green.instance()
	instance_vert.connect("supp_domino_vert",self,"supp_domino_handle")
	if base :
		if $"%PanelBase".get_child_count() - 1 < max_nb_domino :
			instance_vert.position = $"%BasePoint".position + (Vector2.RIGHT * distance_domino * ($"%PanelBase".get_child_count() - 1))
			$"%PanelBase".add_child(instance_vert)
			base_dominos.append(Global.get_color(instance_vert.filename))
	elif objectif :
		if $"%PanelObjectif".get_child_count() - 1 < max_nb_domino :
			instance_vert.position = $"%ObjectifPoint".position + (Vector2.RIGHT * distance_domino * ($"%PanelObjectif".get_child_count() - 1))
			$"%PanelObjectif".add_child(instance_vert)
			objectif_dominos.append(Global.get_color(instance_vert.filename))
	elif regle_select != -1:
		ajouter_a_regle(instance_vert)

func _on_DominoPaletteJaune_click_domino_jaune():
	var instance_jaune = domino_yellow.instance()
	instance_jaune.connect("supp_domino_jaune",self,"supp_domino_handle")
	if base :
		if $"%PanelBase".get_child_count() - 1 < max_nb_domino :
			instance_jaune.position = $"%BasePoint".position + (Vector2.RIGHT * distance_domino * ($"%PanelBase".get_child_count() - 1))
			$"%PanelBase".add_child(instance_jaune)
			base_dominos.append(Global.get_color(instance_jaune.filename))
	elif objectif :
		if $"%PanelObjectif".get_child_count() - 1 < max_nb_domino :
			instance_jaune.position = $"%ObjectifPoint".position + (Vector2.RIGHT * distance_domino * ($"%PanelObjectif".get_child_count() - 1))
			$"%PanelObjectif".add_child(instance_jaune)
			objectif_dominos.append(Global.get_color(instance_jaune.filename))
	elif regle_select != -1:
		ajouter_a_regle(instance_jaune)

func _on_DominoPaletteRose_click_domino_rose():
	var instance_rose = pinkfloyd.instance()
	instance_rose.connect("supp_domino_rose",self,"supp_domino_handle")
	if base :
		if $"%PanelBase".get_child_count() - 1 < max_nb_domino :
			instance_rose.position = $"%BasePoint".position + (Vector2.RIGHT * distance_domino * ($"%PanelBase".get_child_count() - 1))
			$"%PanelBase".add_child(instance_rose)
			base_dominos.append(Global.get_color(instance_rose.filename))
	elif objectif :
		if $"%PanelObjectif".get_child_count() - 1 < max_nb_domino :
			instance_rose.position = $"%ObjectifPoint".position + (Vector2.RIGHT * distance_domino * ($"%PanelObjectif".get_child_count() - 1))
			$"%PanelObjectif".add_child(instance_rose)
			objectif_dominos.append(Global.get_color(instance_rose.filename))
	elif regle_select != -1:
		ajouter_a_regle(instance_rose)

# --------- Signal handler base slection ---------
func _on_PanelBase_gui_input(event):
	if event is InputEventMouseButton and event.button_index == BUTTON_LEFT and event.is_pressed():
		base = true
		objectif = false
		$"%PanelBase".color = Color.gainsboro
		$"%PanelObjectif".color = Color.white
		regle_select = -1
		emit_signal("base_activer",-1)
	if event is InputEventMouseButton and event.button_index == BUTTON_RIGHT and event.is_pressed():
		_propagate_event(event,$"%PanelBase")

# --------- Signal handler objective selection ---------
func _on_PanelObjectif_gui_input(event):
	if event is InputEventMouseButton and event.button_index == BUTTON_LEFT and event.is_pressed():
		objectif = true
		$"%PanelObjectif".color = Color.gainsboro
		base = false
		$"%PanelBase".color = Color.white
		regle_select = -1
		emit_signal("base_activer",-1)
	if event is InputEventMouseButton and event.button_index == BUTTON_RIGHT and event.is_pressed():
		_propagate_event(event,$"%PanelObjectif")

# --------- Signal handler add rule button ---------
func _on_Button_pressed():
	if $"%PanelRegles".get_child_count() -1 < max_nb_regles :
		var instance_regle = regle_inst.instance()
		instance_regle.position = $"%ReglePoint".position + (Vector2.DOWN * 60 * ($"%PanelRegles".get_child_count() - 1))
		instance_regle.get_children()[1].mouse_default_cursor_shape = 2
		instance_regle.connect("regle_activer",self,"regle_activer_handle")
		instance_regle.connect("regle_supprimer",self,"regle_supprimer_handle")
		instance_regle.connect("regle_supp_domino",self,"regle_supp_domino_handle")
		$"%PanelRegles".add_child(instance_regle)
		regle_activer_handle($"%PanelRegles".get_child_count())
		instance_regle.activer_focus()

# --------- Signal handlers remove rule focus ---------
func _on_Fond_base_activer(index_regle):
	var children = $"%PanelRegles".get_children()
	for child in children:
		if child is Position2D or (index_regle != -1 and child.get_index() == index_regle) :
			continue
		if child.name.find("Regle") >= 0:
			remove_focus_regle(child)

# --------- Signal handler play level ---------
# met tous les dominos dans current_level et change de scene
func _on_BJouer_pressed():
	var temp
	var regles = []
	Global.current_level["Base"] = base_dominos.duplicate()
	Global.current_level["Obj"] = objectif_dominos.duplicate()
	for child in $"%PanelRegles".get_children():
		if not (child is Position2D):
			if (child.cote_gauche.size() <= 1 and child.cote_droit.size() == 0) or \
			(child.cote_droit.size() <= 1 and child.cote_gauche.size() == 0):
				continue
			temp = []
			temp.append(child.cote_gauche)
			temp.append(child.cote_droit)
			regles.append(temp)
	if regles:
		Global.current_level["Reg"] = regles.duplicate()
	else:
		Global.current_level["Reg"] = []
		
	
	var error = get_tree().change_scene("res://Scenes/Test.tscn")
	if error != OK :
			print("Failed to change scene", error)
# --------- Signal handler save level ---------
# sauvegarde dans save, test, et rajoute au niveaux créés
func _on_BSauvegarder_pressed():
	$PopupDialog/TextEdit.text = ''
	$PopupDialog.popup_centered()

# charge un niveau depuis la variable test actuellement, doit charger depuis une save ou une 
func _on_BCharger_pressed():
	
	$LoadMenu.popup_centered()
	
	
# --------- Signal handler delete domino ---------
func supp_domino_handle(id, parent):
	var child_to_remove = parent.get_child(id)
	parent.remove_child(child_to_remove)
	var parent_name = parent.name
	var list_to_pop
	var adjust_distance

	if parent_name == 'Gauche':
		list_to_pop = parent.get_parent().get_parent().cote_gauche
		adjust_distance = 10
	elif parent_name == 'Droite':
		list_to_pop = parent.get_parent().get_parent().cote_droit
		adjust_distance = 10
	elif parent_name == 'PanelBase':
		list_to_pop = base_dominos
		adjust_distance = distance_domino
	elif parent_name == 'PanelObjectif':
		list_to_pop = objectif_dominos
		adjust_distance = distance_domino

	if list_to_pop:
		list_to_pop.pop_at(id - 2 if parent_name in ['Gauche', 'Droite'] else id - 1)
		for i in range(id, parent.get_child_count()):
			parent.get_child(i).position.x -= adjust_distance

func regle_supp_domino_handle(index):
	_propagate_event_regle($"%PanelRegles".get_child(index))

# --------- Signal handler delete rule ---------
func regle_supprimer_handle(index):
	$"%PanelRegles".remove_child($"%PanelRegles".get_child(index))
	for i in range(index, $"%PanelRegles".get_child_count()):
		$"%PanelRegles".get_child(i).position.y -= 60


# --------- Helper functions ---------
func regle_activer_handle(index):
	regle_select = index
	base = false
	objectif = false
	$"%PanelBase".color = Color.white
	$"%PanelObjectif".color = Color.white
	
	_on_Fond_base_activer(index)

func remove_focus_regle(regle):
	regle.regle = false
	regle.droite = false
	regle.gauche = false
	
	# Getting ColorRect 
	var regle_children = regle.get_children()[0]
	regle_children.color = Color.white
	#Getting the children of ColorRect
	regle_children = regle_children.get_children()
	regle_children[1].color = Color.white
	regle_children[3].color = Color.white

func ajouter_a_regle(instance):
	# regle contient le noeud de la scène (Node2D)
	var regle = $"%PanelRegles".get_children()[regle_select]
	#sous regle contient les enfants : AreaPrincipale, Gauche,Flèche,Droite
	var sous_regle = regle.get_children()[0].get_children()
	if regle.droite:
		if sous_regle[3].get_child_count() - 2 < max_nb_domino_par_cote_regle :
			instance.position = sous_regle[3].get_children()[1].position + (Vector2.RIGHT * 10 * (sous_regle[3].get_child_count() - 2))
			instance.scale = Vector2(0.15,0.15)
			sous_regle[3].add_child(instance)
			regle.cote_droit.append(Global.get_color(instance.filename))
	elif regle.gauche:
		if sous_regle[1].get_child_count() - 2 < max_nb_domino_par_cote_regle :
			instance.position = sous_regle[1].get_children()[1].position + (Vector2.RIGHT * 10 * (sous_regle[1].get_child_count() - 2))
			instance.scale = Vector2(0.15,0.15)
			sous_regle[1].add_child(instance)
			regle.cote_gauche.append(Global.get_color(instance.filename))

func _propagate_event(event,node):
	var mouse_pos = get_local_mouse_position()
	for child in node.get_children():
		if not (child is Position2D) and child.get_rect(null).has_point(mouse_pos):
			if event != null:
				child.input(event)
			break

func _propagate_event_regle(node):
	var mouse_pos = get_global_mouse_position()
	var gauche = node.get_children()[0].get_children()[1].get_children()
	var droite = node.get_children()[0].get_children()[3].get_children()
	for element in gauche:
		if not (element is Position2D or element is Area2D) and element.get_rect(1).has_point(mouse_pos):
			var event = InputEventMouseButton.new()
			event.button_index = BUTTON_RIGHT
			event.pressed = true
			element.input(event)
			break
	for element in droite:
		if not (element is Position2D or element is Area2D) and element.get_rect(1).has_point(mouse_pos):
			var event = InputEventMouseButton.new()
			event.button_index = BUTTON_RIGHT
			event.pressed = true
			element.input(event)
			break

# Supprime tous les dominos
func supprimer_tout():
	base_dominos = []
	objectif_dominos = []
	#Supprime les dominos existants
	for child in $"%PanelBase".get_children():
		if not (child is Position2D):
			$"PanelFond/PanelBase".remove_child(child)
	
	for child in $"%PanelObjectif".get_children():
		if not (child is Position2D):
			$"%PanelObjectif".remove_child(child)
			
	for child in $"%PanelRegles".get_children():
		if not (child is Position2D):
			$"%PanelRegles".remove_child(child)



func _on_Menu_pressed():
	var error = get_tree().change_scene("res://Scenes/Menus/MainMenu.tscn")
	if error != OK :
			print("Failed to change scene", error)

func save_game(save):
	# Ensure the save directory exists
	var dir = Directory.new()
	if not dir.dir_exists(SAVE_DIR):
		var err = dir.make_dir_recursive(SAVE_DIR)
		if err != OK:
			print("Failed to create save directory:", err)
			return

	if Global.save_nbr <= MAX_SAVES:
		var file_path = SAVE_DIR + save["Name"] + SAVE_EXTENSION
		var file = File.new()
		var err = file.open(file_path, File.WRITE)
		if err == OK:
			file.store_var(save)
			file.close()
			print("Level saved to slot", save)
		else:
			print("Failed to save level:", err)
			print("File path:", file_path)
	else:
		print("Maximum number of saves reached")



func _on_Confirm_pressed():
	
	$PopupDialog.hide()
	
	test = {}
	var temp:Array
	var regles:Array = []
	var save = {}
	if base_dominos.empty() and objectif_dominos.empty():
		return
	save["Name"] = $PopupDialog/TextEdit.text 
	save["Base"] = base_dominos.duplicate()
	save["Obj"] = objectif_dominos.duplicate()
	for child in $"%PanelRegles".get_children():
		if not (child is Position2D):
			temp = []
			temp.append(child.cote_gauche)
			temp.append(child.cote_droit)
			regles.append(temp)
	
	save["Reg"] = regles.duplicate()
	test = save.duplicate()
	
	save_game(save)
	
	print(save)
	
#	Global.levels_created.append(save)
	Global.list_saves()
	$LoadMenu.draw_levels()

func _on_Undo_pressed():
	$PopupDialog.hide()


func _on_LoadMenu_niveau_selectionne(nom):
	$LoadMenu.draw_levels()
	test = Global.load_game(nom)
	
	if test != null:
		remplir_niveau()
		$LoadMenu.hide()
func remplir_niveau():
		var instance
		supprimer_tout()
		#Ajoute la base
		for domino in test["Base"]:
			instance = Global.get_domino(self,domino)
			instance.position = $"%BasePoint".position + (Vector2.RIGHT * distance_domino * ($"%PanelBase".get_child_count() - 1))
			$"%PanelBase".add_child(instance)
			base_dominos.append(Global.get_color(instance.filename))

		#Ajoute l'objectif
		for domino in test["Obj"]:
			instance = Global.get_domino(self,domino)
			instance.position = $"%ObjectifPoint".position + (Vector2.RIGHT * distance_domino * ($"%PanelObjectif".get_child_count() - 1))
			$"%PanelObjectif".add_child(instance)
			objectif_dominos.append(Global.get_color(instance.filename))
		
		#Ajoute les regles
		
		# Chaque regle
		for regle in test["Reg"]:
			#Instancie la scène de la regle (signaux + position)
			var instance_regle = regle_inst.instance()
			instance_regle.position = $"%ReglePoint".position + (Vector2.DOWN * 60 * ($"%PanelRegles".get_child_count() - 1))
			instance_regle.connect("regle_activer",self,"regle_activer_handle")
			instance_regle.connect("regle_supprimer",self,"regle_supprimer_handle")
			instance_regle.connect("regle_supp_domino",self,"regle_supp_domino_handle")
			#recupère les enfants de la scene pour avoir coté droit et gauche
			var sous_regle = instance_regle.get_children()[0].get_children()
			#cote gauche
			for domino in regle[0]:
				if instance != null:
					instance = Global.get_domino(self,domino)
					instance.position = sous_regle[1].get_children()[1].position + (Vector2.RIGHT * 10 * (sous_regle[1].get_child_count() - 2))
					instance.scale = Vector2(0.15,0.15)
					sous_regle[1].add_child(instance)
					instance_regle.cote_gauche.append(Global.get_color(instance.filename))
			#cote droit
			for domino in regle[1]:
				instance = Global.get_domino(self,domino)
				if instance != null:
					instance.position = sous_regle[3].get_children()[1].position + (Vector2.RIGHT * 10 * (sous_regle[3].get_child_count() - 2))
					instance.scale = Vector2(0.15,0.15)
					sous_regle[3].add_child(instance)
					instance_regle.cote_droit.append(Global.get_color(instance.filename))

			$"%PanelRegles".add_child(instance_regle)
