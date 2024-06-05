extends Node2D


func _on_Editer_pressed():
	var error = get_tree().change_scene("res://Scenes/Edition.tscn")
	if error != OK :
			print("Failed to change scene", error)
