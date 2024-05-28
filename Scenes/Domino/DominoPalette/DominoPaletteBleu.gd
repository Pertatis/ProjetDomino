extends Node2D

signal click_domino_bleu


func _on_DominoPaletteBleu_input_event(_viewport, event, _shape_idx):
	if event is InputEventMouseButton and event.button_index == BUTTON_LEFT and event.is_pressed():
		emit_signal("click_domino_bleu")
