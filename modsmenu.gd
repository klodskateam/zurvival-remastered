extends Node2D

const MOD_ITEM = preload("res://mod_item.tscn")

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	for sus in ModLoader.MODSLIST.size():
		var filepath = "user://mods/" + ModLoader.MODSLIST[sus]
		var file = FileAccess.open(filepath, FileAccess.READ)
		var json = JSON.new()
		var tmp_mod = json.parse_string(file.get_as_text())
		
		print(str(tmp_mod))
		
		var ModItem = MOD_ITEM.instantiate()
		if "name" in tmp_mod:
			ModItem.NAME = tmp_mod["name"]
		if "description" in tmp_mod:
			ModItem.DESC = tmp_mod["description"]
		if "icon" in tmp_mod:
			ModItem.IMG = ModLoader.get_mod_img(tmp_mod["icon"])
		if "website" in tmp_mod:
			ModItem.URL = tmp_mod["website"]
		
		$Control/Panel/VBoxContainer/VBoxContainer.add_child(ModItem)


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass

# ну теперь то робит 📸
func _on_open_dir_button_down() -> void:
	OS.shell_open(OS.get_user_data_dir() + "/mods")


func _on_settings_save_pressed() -> void:
	get_tree().change_scene_to_file("res://menu.tscn")


func _on_mods2_pressed() -> void:
	get_tree().change_scene_to_file("res://modsinternet.tscn")
