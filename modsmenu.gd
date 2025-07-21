extends Node2D

const MOD_ITEM = preload("res://mod_item.tscn")
@onready var transition = get_tree().current_scene.get_node("Control")
@onready var background = get_tree().current_scene.get_node("Background/Sprite2D")

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
	if not transition.imfinished.is_connected(Global.got_finishedsign):
		transition.imfinished.connect(Global.got_finishedsign)


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass

# ну теперь то робит 📸
func _on_open_dir_button_down() -> void:
	OS.shell_open(OS.get_user_data_dir() + "/mods")


func _on_settings_save_pressed() -> void:
#	get_tree().change_scene_to_file("res://menu.tscn")
	background.save_id()
	Global.FROM = 3
	transition.right(6)

func _on_mods2_pressed() -> void:
#	get_tree().change_scene_to_file("res://modsinternet.tscn")
	background.save_id()
	Global.FROM = 1
	transition.down(5)
