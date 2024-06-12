extends Control


func _ready():
	pass



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
