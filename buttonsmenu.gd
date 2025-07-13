extends Button

@onready var GAME = "res://gamemode.tscn"
@onready var SETTINGS = "res://settings.tscn"
@onready var transition = get_tree().current_scene.get_node("Control")
@onready var background = get_tree().current_scene.get_node("Background/Sprite2D")
var config = ConfigFile.new()

func _ready() -> void:
	if not transition.imfinished.is_connected(Global.got_finishedsign):
		transition.imfinished.connect(Global.got_finishedsign)

func _on_play_pressed():
	print("GAME1")
#	get_tree().change_scene_to_file(GAME)
	background.save_id()	
	Global.FROM = 1
	transition.down(1)

func _on_settings_pressed():
	print("SETTINGS")
#	get_tree().change_scene_to_file(SETTINGS)
	background.save_id()
	Global.FROM = 3
	transition.right(2)
	
func _on_settings_back_pressed():
	config.load(Global.SAVE_PATH)
	var tmp_aims = config.get_value("items", "aims", [])
	config.set_value("settings", "fullscreen", $"../VBoxContainer/SettingsFullscreenCheck".button_pressed)
	config.set_value("settings", "lang", TranslationServer.get_loaded_locales()[$"../VBoxContainer/SettingsLang".selected])
	config.set_value("save", "zcoins", Global.ZCOINS)
	config.set_value("items", "aims", tmp_aims)
	config.save(Global.SAVE_PATH)
	#get_tree().change_scene_to_file("res://menu.tscn")
	background.save_id()
	Global.FROM = 4
	transition.left(6)
	
func _on_exit_pressed():
#	get_tree().quit()
	background.save_id()
	transition.up(4)
	pass


func _on_mods_pressed() -> void:
#	get_tree().change_scene_to_file("res://mods.tscn")
	background.save_id()
	Global.FROM = 4
	transition.left(3)
	pass
	
