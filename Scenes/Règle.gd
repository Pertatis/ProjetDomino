extends Node2D

# --------- Signals ---------
signal regle_activer(index)
signal regle_supprimer(index)
signal regle_clicked(index)
signal regle_supp_domino(index)
# --------- Variables ---------
var cote_droit:Array
var cote_gauche:Array

var selected:bool = false

var gauche:bool = false
var droite:bool = false
var regle: bool = false


# --------- Signal handlers regle ---------
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
	if event is InputEventMouseButton and event.button_index == BUTTON_RIGHT and event.is_pressed():
		emit_signal("regle_supp_domino",get_index())

func _on_Droite_gui_input(event):
	if event is InputEventMouseButton and event.button_index == BUTTON_LEFT and event.is_pressed():
		gauche = false
		droite = true
		$"%Gauche".color = Color.white
		$"%Droite".color = Color.gainsboro
		emit_signal("regle_activer",get_index())
	if event is InputEventMouseButton and event.button_index == BUTTON_RIGHT and event.is_pressed():
		emit_signal("regle_supp_domino",get_index())

func disconnect_signals():
	$"%Gauche".disconnect("gui_input",self,"_on_Gauche_gui_input")
	$"%Droite".disconnect("gui_input",self,"_on_Droite_gui_input")
	$"%ColorRect".disconnect("gui_input",self,"_on_ColorRect_gui_input")

func _on_Button_pressed():
	emit_signal("regle_supprimer",get_index())


func _on_Click_ColorRect(event):
	if event is InputEventMouseButton and event.button_index == BUTTON_LEFT and event.is_pressed():
		emit_signal("regle_clicked",get_index())

func activer_focus():
	regle = true
	gauche = true
	droite = false
	$"%Gauche".color = Color.gainsboro
	$"%Droite".color = Color.white
	$"%ColorRect".color = Color.ghostwhite
	emit_signal("regle_activer",get_index())
