extends Button

@onready var GAME = "res://gamemode.tscn"
@onready var SETTINGS = "res://settings.tscn"
@onready var transition = get_tree().current_scene
var config = ConfigFile.new()

func _on_play_pressed():
	print("GAME1")
#	get_tree().change_scene_to_file(GAME)
	#background.save_id()	
	#Global.FROM = 1
	#transition.down(1)
	transition.doit(Vector2(0, -1), "gamemode", Vector2(0,1))

func _on_settings_pressed():
	print("SETTINGS")
#	get_tree().change_scene_to_file(SETTINGS)
	#background.save_id()
	#Global.FROM = 3
	transition.doit(Vector2(-1, 0), "settings", Vector2(1,0))
	
func _on_settings_back_pressed():
	config.load(Global.SAVE_PATH)
	var tmp_aims = config.get_value("items", "aims", [])
	config.set_value("settings", "fullscreen", $"../VBoxContainer/SettingsFullscreenCheck".button_pressed)
	config.set_value("settings", "lang", TranslationServer.get_loaded_locales()[$"../VBoxContainer/SettingsLang".selected])
	config.set_value("settings", "smoothtransitions", $"../VBoxContainer/SettingsTransitionCheck".button_pressed)
	config.set_value("settings", "cheapeffects", $"../VBoxContainer/SettingsCheapEffectsCheck".button_pressed)
	config.set_value("settings", "disableshadows", $"../VBoxContainer/SettingsShadowsCheck".button_pressed)
	config.set_value("settings", "disableweaponhints", $"../VBoxContainer/SettingsHintsCheck".button_pressed)
	config.set_value("settings", "gamepad_sens", Global.GAYPAD_AIDS)
	config.set_value("save", "zcoins", Global.ZCOINS)
	config.set_value("items", "aims", tmp_aims)
	config.save(Global.SAVE_PATH)
	#get_tree().change_scene_to_file("res://menu.tscn")
	#background.save_id()
	Global.FROM = 4
	transition.doit(Vector2(1, 0), "menu", Vector2(-1,0))
	
func _on_exit_pressed():
#	get_tree().quit()
	#background.save_id()
	transition.doit(Vector2(0, 1), "menublackscreen", Vector2(0,-1))
	pass


func _on_mods_pressed() -> void:
#	get_tree().change_scene_to_file("res://mods.tscn")
	#background.save_id()
	#Global.FROM = 4
	transition.doit(Vector2(1, 0), "mods", Vector2(-1,0))
	pass
	
