extends Node2D

signal ligne_historique_clicked

func _on_HistoriqueLigne_gui_input(event):
	if event is InputEventMouseButton and event.button_index == BUTTON_LEFT and event.is_pressed():
		emit_signal("ligne_historique_clicked",get_index())
