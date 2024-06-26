extends Control


func _ready():
	Global.current_level = {}



func _on_Resolution_pressed():
	
	$LoadMenu.popup_centered()


func _on_Edition_pressed():
	var error = get_tree().change_scene("res://Scenes/Edition.tscn")
	if error != OK :
			print("Failed to change scene", error)


func _on_Quitter_pressed():
	get_tree().quit()


func _on_LoadMenu_niveau_selectionne(nom):
	Global.current_level = Global.load_game(nom)
	
	$LoadMenu.hide()
	
	var error = get_tree().change_scene("res://Scenes/Resolution.tscn")
	print(OS.get_user_data_dir())
	if error != OK :
			print("Failed to change scene", error)
