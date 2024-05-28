extends Node2D

signal click_domino_vert


func _on_DominoPaletteVert_input_event(_viewport, event, _shape_idx):
	if event is InputEventMouseButton and event.button_index == BUTTON_LEFT and event.is_pressed():
		emit_signal("click_domino_vert")
