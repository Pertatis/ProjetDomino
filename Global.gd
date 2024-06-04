extends Node


func get_color(filename):
	if "Bleu" in filename:
		return 'B'
	if "Rouge" in filename:
		return 'R'
	if "Vert" in filename:
		return 'G'
	if "Jaune" in filename:
		return 'Y'
	if "Rose" in filename:
		return "P"
