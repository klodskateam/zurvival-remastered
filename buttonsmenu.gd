extends Button

@onready var GAME = "res://game.tscn"
@onready var SETTINGS = "res://settings.tscn"

var config = ConfigFile.new()

func _on_pressed():
	print("GAME")
	get_tree().change_scene_to_file(GAME)

func _on_settings_pressed():
	print("SETTINGS")
	get_tree().change_scene_to_file(SETTINGS)
	
func _on_settings_back_pressed():
	config.set_value("settings", "fullscreen", $"../VBoxContainer/SettingsFullscreenCheck".button_pressed)
	config.set_value("settings", "lang", TranslationServer.get_loaded_locales()[$"../VBoxContainer/SettingsLang".selected])
	config.save(Global.SAVE_PATH)
	get_tree().change_scene_to_file("res://menu.tscn")
