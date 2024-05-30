extends Node2D

signal regle_activer(index)

var gauche:bool = false
var droite:bool = false
var regle: bool = false

func _ready():
	pass

func _on_ColorRect_gui_input(event):
	if event is InputEventMouseButton and event.button_index == BUTTON_LEFT and event.is_pressed():
		regle = true
		$"%ColorRect".color = Color.ghostwhite
		if not droite:
			gauche = true
			$"%Gauche".color = Color.gainsboro
		emit_signal("regle_activer",get_index())

func _on_Gauche_gui_input(event):
	if event is InputEventMouseButton and event.button_index == BUTTON_LEFT and event.is_pressed():
		gauche = true
		droite = false
		$"%Gauche".color = Color.gainsboro
		$"%Droite".color = Color.white
		emit_signal("regle_activer",get_index())

func _on_Droite_gui_input(event):
	if event is InputEventMouseButton and event.button_index == BUTTON_LEFT and event.is_pressed():
		gauche = false
		droite = true
		$"%Gauche".color = Color.white
		$"%Droite".color = Color.gainsboro
		emit_signal("regle_activer",get_index())
