extends Node2D

# --------- Signals ---------
signal click_domino_rose
signal supp_domino_rose(id,parent)
signal select_domino_rose(id)

# --------- Signal handlers ---------
func _on_DominoPaletteRose_input_event(_viewport, event, _shape_idx):
	if event is InputEventMouseButton and event.button_index == BUTTON_LEFT and event.is_pressed():
		emit_signal("click_domino_rose")
		emit_signal("select_domino_rose",get_index())
	if event is InputEventMouseButton and event.button_index == BUTTON_RIGHT and event.is_pressed():
		emit_signal("supp_domino_rose",get_index(),get_parent())


# --------- Helper functions ---------
func input(event):
	_on_DominoPaletteRose_input_event(null,event,null)

func get_rect(where):
	var sprite = get_children()[1]  # Adjust the path to your Sprite node
	var size = Vector2()
	if sprite.texture:
		size = sprite.texture.get_size() * sprite.scale
		if where != null:
			size = size * 0.18
	return Rect2(global_position - size / 2, size)
