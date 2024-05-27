extends Node2D

signal click_domino_rouge



func _on_DominoPaletteRouge_input_event(viewport, event, shape_idx):
	if event is InputEventMouseButton and event.button_index == BUTTON_LEFT and event.is_pressed():
		emit_signal("click_domino_rouge")
