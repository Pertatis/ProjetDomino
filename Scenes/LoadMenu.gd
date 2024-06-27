extends Control

var niveau_instance:PackedScene = preload("res://Scenes/Niveau.tscn")

signal niveau_selectionne(nom)

func _ready():
#	$".".popup()
	draw_levels()


func draw_levels():
	for element in $"%ColorRect".get_children():
		if not (element is Position2D):
			 $"%ColorRect".remove_child(element)
	$"%ColorRect".rect_min_size = Vector2(0, 40)
	var i = 1
	var made_levels = []
	for level in Global.levels_created:
		made_levels.append(level["Name"])
	var all_levels = made_levels + Global.save_files
	print(all_levels)
	
	for level in all_levels:
		var inst = niveau_instance.instance()
		inst.connect("niveau_click",self,"niveau_click_handle")
		inst.connect("niveau_supp",self,"niveau_supp_handle")
		inst.rect_position += $"%Position2D".position + (Vector2.DOWN * 60 * ($"%ColorRect".get_child_count() - 1))
		$"%ColorRect".add_child(inst)
		
		var niv = inst.get_child(0)
		niv.get_child(0).text = str(i)
		i += 1
		if level is String:
			niv.get_child(1).text = level
		
		$"%ColorRect".rect_min_size += Vector2(0, 60)


func _on_TextureButton_pressed():
	$".".hide()
	
func niveau_click_handle(nom):
	emit_signal("niveau_selectionne",nom)
	

func niveau_supp_handle(nom):
	var file_path = Global.SAVE_DIR + nom + Global.SAVE_EXTENSION
	var file = Directory.new()
	
	# Check if the file exists before attempting deletion
	if file.file_exists(file_path):
		var err = file.remove(file_path)
		if err == OK:
			print("Deleted save:", nom)
			Global.save_files.erase(nom)
			for element in Global.levels_created:
				if element["Name"] == nom:
					Global.levels_created.erase(element)
					break
			for element in $"%ColorRect".get_children():
				if not (element is Position2D):
					$"%ColorRect".remove_child(element)
			draw_levels()

		else:
			print("Failed to delete save:", err)
			print("File path:", file_path)
		
		
	else:
		print("Save file not found:", nom)
		
	
