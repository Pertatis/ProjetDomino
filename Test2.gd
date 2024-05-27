extends Node2D


var domino_scene:PackedScene = preload("res://Scenes/Domino/DominoPalette.tscn")
var domino_blue:PackedScene = preload("res://Scenes/Domino/DominoPaletteBleu.tscn")
var domino_red:PackedScene = preload("res://Scenes/Domino/DominoPaletteRouge.tscn")
var domino_green:PackedScene = preload("res://Scenes/Domino/DominoPaletteVert.tscn")


func _ready():
#	var sig = $Back/DominoPaletteBleu
#	sig.connect('click_domino_bleu',self,'_on_DominoPaletteBleu_click_domino_bleu')
	pass

func _process(_delta):
#	if Input.is_action_just_pressed("ui_accept") and (true):
#		var inst = domino_scene.instance()
#		inst.scale = Vector2(0.8, 0.8)
#		if get_child_count() < 12 :
#			inst.position = $Position2D.position + (Vector2.RIGHT * 50 * (get_child_count() - 1))
#			add_child(inst)
	pass




#func _on_DominoPaletteBleu_click_on_blue():
#	var inst = domino_scene.instance()
#	inst.scale = Vector2(0.8, 0.8)
##	inst.connect("click_on_blue", self, "_on_DominoPaletteBleu_click_on_blue")
#	if get_child_count() < 12 :
#		inst.position = $Position2D.position + (Vector2.RIGHT * 50 * (get_child_count() - 1))
#		add_child(inst)
#
#




func _on_DominoPaletteBleu_click_domino_bleu():
	print("haw zeb")
