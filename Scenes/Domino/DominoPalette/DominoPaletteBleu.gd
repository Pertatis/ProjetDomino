extends Node2D

signal click_domino_bleu
signal supp_domino_bleu(id)


func _on_DominoPaletteBleu_input_event(_viewport, event, _shape_idx):
	if event is InputEventMouseButton and event.button_index == BUTTON_LEFT and event.is_pressed():
		emit_signal("click_domino_bleu")
	if event is InputEventMouseButton and event.button_index == BUTTON_RIGHT and event.is_pressed():
		emit_signal("supp_domino_bleu",get_instance_id())
