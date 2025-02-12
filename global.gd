extends Node

var VERSION = ProjectSettings.get_setting("application/config/version")
var FULLSCREEN = false

const SAVE_PATH = "user://save.cfg"
var CONFIG = ConfigFile.new()

func _input(event: InputEvent) -> void:
	if event.is_action_pressed("fullscreenkey"):
		if FULLSCREEN == false:
			DisplayServer.window_set_mode(DisplayServer.WINDOW_MODE_FULLSCREEN)
			FULLSCREEN = true
		else:
			DisplayServer.window_set_mode(DisplayServer.WINDOW_MODE_WINDOWED)
			FULLSCREEN = false
	
func _ready() -> void:
	CONFIG.load(SAVE_PATH)
	TranslationServer.set_locale(CONFIG.get_value("settings", "lang"))
	if CONFIG.get_value("settings", "fullscreen") == true:
		DisplayServer.window_set_mode(DisplayServer.WINDOW_MODE_FULLSCREEN)
