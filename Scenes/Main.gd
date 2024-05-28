extends Node2D


var domino_blue:PackedScene = preload("res://Scenes/Domino/DominoPalette/DominoPaletteBleu.tscn")
var domino_red:PackedScene = preload("res://Scenes/Domino/DominoPalette/DominoPaletteRouge.tscn")
var domino_green:PackedScene = preload("res://Scenes/Domino/DominoPalette/DominoPaletteVert.tscn")
var pinkfloyd:PackedScene = preload("res://Scenes/Domino/DominoPalette/DominoPaletteRose.tscn")
var domino_yellow:PackedScene = preload("res://Scenes/Domino/DominoPalette/DominoPaletteJaune.tscn")

const max_nb_domino = 13

func _ready():
#	var sig = $Back/DominoPaletteBleu
#	sig.connect('click_domino_bleu',self,'_on_DominoPaletteBleu_click_domino_bleu')
	pass

func _process(_delta):
	pass

func _on_DominoPaletteBleu_click_domino_bleu():
	var instance_bleu = domino_blue.instance()
	if $PanelFond/PanelBase.get_child_count() - 1 < max_nb_domino :
		instance_bleu.position = $PanelFond/PanelBase/Position2D.position + (Vector2.RIGHT * 45 * ($PanelFond/PanelBase.get_child_count() - 1))
		$PanelFond/PanelBase.add_child(instance_bleu)

func _on_DominoPaletteVert_click_domino_vert():
	var instance_vert = domino_green.instance()
	if $PanelFond/PanelBase.get_child_count() - 1 < max_nb_domino :
		instance_vert.position = $PanelFond/PanelBase/Position2D.position + (Vector2.RIGHT * 45 * ($PanelFond/PanelBase.get_child_count() - 1))
		$PanelFond/PanelBase.add_child(instance_vert)

func _on_DominoPaletteRouge_click_domino_rouge():
	var instance_rouge = domino_red.instance()
	if $PanelFond/PanelBase.get_child_count() - 1 < max_nb_domino :
		instance_rouge.position = $PanelFond/PanelBase/Position2D.position + (Vector2.RIGHT * 45 * ($PanelFond/PanelBase.get_child_count() - 1))
		$PanelFond/PanelBase.add_child(instance_rouge)

func _on_DominoPaletteRose_click_domino_rose():
	var instance_rose = pinkfloyd.instance()
	if $PanelFond/PanelBase.get_child_count() - 1 < max_nb_domino :
		instance_rose.position = $PanelFond/PanelBase/Position2D.position + (Vector2.RIGHT * 45 * ($PanelFond/PanelBase.get_child_count() - 1))
		$PanelFond/PanelBase.add_child(instance_rose)

func _on_DominoPaletteJaune_click_domino_jaune():
	var instance_jaune = domino_yellow.instance()
	if $PanelFond/PanelBase.get_child_count() - 1 < max_nb_domino :
		instance_jaune.position = $PanelFond/PanelBase/Position2D.position + (Vector2.RIGHT * 45 * ($PanelFond/PanelBase.get_child_count() - 1))
		$PanelFond/PanelBase.add_child(instance_jaune)
