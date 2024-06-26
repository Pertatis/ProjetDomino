extends Control


# Declare member variables here. Examples:
# var a = 2
# var b = "text"

signal niveau_click
signal niveau_supp

# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta):
#	pass


func _on_Panel_gui_input(event):
	if event is InputEventMouseButton and event.button_index == BUTTON_LEFT and event.is_pressed():
		emit_signal("niveau_click",$Panel/NomNiveau.text)


func _on_Button_pressed():
	emit_signal("niveau_supp",$Panel/NomNiveau.text)
	
