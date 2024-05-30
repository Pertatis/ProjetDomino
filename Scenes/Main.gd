extends Node2D


var domino_blue:PackedScene = preload("res://Scenes/Domino/DominoPalette/DominoPaletteBleu.tscn")
var domino_red:PackedScene = preload("res://Scenes/Domino/DominoPalette/DominoPaletteRouge.tscn")
var domino_green:PackedScene = preload("res://Scenes/Domino/DominoPalette/DominoPaletteVert.tscn")
var pinkfloyd:PackedScene = preload("res://Scenes/Domino/DominoPalette/DominoPaletteRose.tscn")
var domino_yellow:PackedScene = preload("res://Scenes/Domino/DominoPalette/DominoPaletteJaune.tscn")

var regle_inst:PackedScene = preload("res://Scenes/Règle.tscn")

signal base_activer(index_regle)

var base:bool = false
var objectif:bool = false


const max_nb_domino = 13
const max_nb_regles = 8
func _ready():
	base = true
	$"%PanelBase".color = Color.gainsboro

func _process(_delta):
	pass

func _on_DominoPaletteBleu_click_domino_bleu():
	var instance_bleu = domino_blue.instance()
	if base :
		if $"%PanelBase".get_child_count() - 1 < max_nb_domino :
			instance_bleu.position = $"%BasePoint".position + (Vector2.RIGHT * 45 * ($"%PanelBase".get_child_count() - 1))
			$"%PanelBase".add_child(instance_bleu)
	elif objectif :
		if $"%PanelObjectif".get_child_count() - 1 < max_nb_domino :
			instance_bleu.position = $"%ObjectifPoint".position + (Vector2.RIGHT * 45 * ($"%PanelObjectif".get_child_count() - 1))
			$"%PanelObjectif".add_child(instance_bleu)

func _on_DominoPaletteVert_click_domino_vert():
	var instance_vert = domino_green.instance()
	if base :
		if $"%PanelBase".get_child_count() - 1 < max_nb_domino :
			instance_vert.position = $"%BasePoint".position + (Vector2.RIGHT * 45 * ($"%PanelBase".get_child_count() - 1))
			$"%PanelBase".add_child(instance_vert)
	elif objectif :
		if $"%PanelObjectif".get_child_count() - 1 < max_nb_domino :
			instance_vert.position = $"%ObjectifPoint".position + (Vector2.RIGHT * 45 * ($"%PanelObjectif".get_child_count() - 1))
			$"%PanelObjectif".add_child(instance_vert)

func _on_DominoPaletteRouge_click_domino_rouge():
	var instance_rouge = domino_red.instance()
	if base :
		if $"%PanelBase".get_child_count() - 1 < max_nb_domino :
			instance_rouge.position = $"%BasePoint".position + (Vector2.RIGHT * 45 * ($"%PanelBase".get_child_count() - 1))
			$"%PanelBase".add_child(instance_rouge)
	elif objectif :
		if $"%PanelObjectif".get_child_count() - 1 < max_nb_domino :
			instance_rouge.position = $"%ObjectifPoint".position + (Vector2.RIGHT * 45 * ($"%PanelObjectif".get_child_count() - 1))
			$"%PanelObjectif".add_child(instance_rouge)

func _on_DominoPaletteRose_click_domino_rose():
	var instance_rose = pinkfloyd.instance()
	if base :
		if $"%PanelBase".get_child_count() - 1 < max_nb_domino :
			instance_rose.position = $"%BasePoint".position + (Vector2.RIGHT * 45 * ($"%PanelBase".get_child_count() - 1))
			$"%PanelBase".add_child(instance_rose)
	elif objectif :
		if $"%PanelObjectif".get_child_count() - 1 < max_nb_domino :
			instance_rose.position = $"%ObjectifPoint".position + (Vector2.RIGHT * 45 * ($"%PanelObjectif".get_child_count() - 1))
			$"%PanelObjectif".add_child(instance_rose)

func _on_DominoPaletteJaune_click_domino_jaune():
	var instance_jaune = domino_yellow.instance()
	if base :
		if $"%PanelBase".get_child_count() - 1 < max_nb_domino :
			instance_jaune.position = $"%BasePoint".position + (Vector2.RIGHT * 45 * ($"%PanelBase".get_child_count() - 1))
			$"%PanelBase".add_child(instance_jaune)
	elif objectif :
		if $"%PanelObjectif".get_child_count() - 1 < max_nb_domino :
			instance_jaune.position = $"%ObjectifPoint".position + (Vector2.RIGHT * 45 * ($"%PanelObjectif".get_child_count() - 1))
			$"%PanelObjectif".add_child(instance_jaune)




func _on_PanelBase_gui_input(event):
	if event is InputEventMouseButton and event.button_index == BUTTON_LEFT and event.is_pressed():
		base = true
		objectif = false
		$"%PanelBase".color = Color.gainsboro
		$"%PanelObjectif".color = Color.white
		emit_signal("base_activer",-1)


func _on_PanelObjectif_gui_input(event):
	if event is InputEventMouseButton and event.button_index == BUTTON_LEFT and event.is_pressed():
		objectif = true
		$"%PanelObjectif".color = Color.gainsboro
		base = false
		$"%PanelBase".color = Color.white
		emit_signal("base_activer",-1)

func _on_Button_pressed():
	if $"%PanelRegles".get_child_count() -1 < max_nb_regles :
		var instance_regle = regle_inst.instance()
		instance_regle.position = $"%ReglePoint".position + (Vector2.DOWN * 60 * ($"%PanelRegles".get_child_count() - 1))
		instance_regle.connect("regle_activer",self,"regle_activer_handle")
		$"%PanelRegles".add_child(instance_regle)

func regle_activer_handle(index):
	base = false
	objectif = false
	$"%PanelBase".color = Color.white
	$"%PanelObjectif".color = Color.white
	
	_on_Fond_base_activer(index)
	


func _on_Fond_base_activer(index_regle):
	var children = $"%PanelRegles".get_children()
	for child in children:
		if child is Position2D or (index_regle != -1 and child.get_index() == index_regle) :
			continue
		if child.name.find("Regle") >= 0:
			remove_focus_regle(child)
			
func remove_focus_regle(regle):
	# Getting ColorRect 
	var regle_children = regle.get_children()[0]
	print(regle_children)
	regle_children.color = Color.white
	#Getting the children of ColorRect
	regle_children = regle_children.get_children()
	regle_children[1].color = Color.white
	regle_children[3].color = Color.white
	
		
