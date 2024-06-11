extends Node2D

# --------- Signals ---------
signal click_domino_bleu
signal supp_domino_bleu(id,parent)
signal select_domino_bleu(id)


# --------- Signal handlers ---------
func _on_DominoPaletteBleu_input_event(_viewport, event, _shape_idx):
	if event is InputEventMouseButton and event.button_index == BUTTON_LEFT and event.is_pressed():
		emit_signal("click_domino_bleu")
		emit_signal("select_domino_bleu",get_index())
	if event is InputEventMouseButton and event.button_index == BUTTON_RIGHT and event.is_pressed():
		emit_signal("supp_domino_bleu",get_index(),get_parent())


# --------- Helper functions ---------
func input(event):
	_on_DominoPaletteBleu_input_event(null,event,null)

func get_rect(where):
	var sprite = get_children()[1]
	var size = Vector2()
	if sprite.texture:
		size = sprite.texture.get_size() * sprite.scale
		if where != null:
			size = size * 0.18
		# -------- TO FIX AND APPLY FOR ALL DOMINOS: Find the correct vector size --------
#		print("original size : ", sprite.texture.get_size())
#		print("height : ", sprite.texture.get_height())
#		print("width : ", sprite.texture.get_width())
#		print("size after scale : ", size)
		return Rect2(global_position - size / 2, size)
