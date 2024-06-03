extends Node2D

signal click_domino_vert
signal supp_domino_vert(id,parent)

func _on_DominoPaletteVert_input_event(_viewport, event, _shape_idx):
	if event is InputEventMouseButton and event.button_index == BUTTON_LEFT and event.is_pressed():
		emit_signal("click_domino_vert")
	if event is InputEventMouseButton and event.button_index == BUTTON_RIGHT and event.is_pressed():
		emit_signal("supp_domino_vert",get_index(),get_parent())


func input(event):
	_on_DominoPaletteVert_input_event(null,event,null)
	

func get_rect():
	var sprite = get_children()[1]  # Adjust the path to your Sprite node
	var size = Vector2()
	if sprite.texture:
		size = sprite.texture.get_size() * sprite.scale
	return Rect2(global_position - size / 2, size)
