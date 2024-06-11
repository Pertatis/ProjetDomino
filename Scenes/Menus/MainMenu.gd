extends Control


# Declare member variables here. Examples:
# var a = 2
# var b = "text"


# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta):
#	pass


func _on_Resolution_pressed():
	var error = get_tree().change_scene("res://Scenes/Resolution.tscn")
	if error != OK :
			print("Failed to change scene", error)


func _on_Edition_pressed():
	var error = get_tree().change_scene("res://Scenes/Edition.tscn")
	if error != OK :
			print("Failed to change scene", error)


func _on_Quitter_pressed():
	get_tree().quit()
