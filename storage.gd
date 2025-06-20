extends Node2D

var my_aims = []

var my_items = []


const SAVE_PATH = "user://save.cfg"
var CONFIG = ConfigFile.new()

func _ready() -> void:
	Global.CONFIG.load(SAVE_PATH)
	
	if Global.CONFIG.get_value("items", "aims"):
		my_aims = Global.CONFIG.get_value("items", "aims")
		print(my_aims)
		
		

func _on_quitstorage_pressed() -> void:
	# куда нужно? 🗣️
	get_tree().change_scene_to_file("res://menu.tscn")
