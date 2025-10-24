# TODO
# [1/2] Доделать прицелы
# [*] Сделать кнопки открытия сайта мода в списке модов
# [*] Добавить больше режимов в игру
# [1/4] Доделать магазин и инвентарь (склад)
# [ ] Добавить режимы в модлоадер
# [-] Вернуть Discord Rich Preference (или как его) из 1.3 и ниже
# [*] добавьте больше TODO🤪🤪🤪 


# INFO самые важные песни зр 2.0 это:
# бутырка метеорит

# чтооо годот подсветка комментариев😨
# ALERT, ATTENTION, CAUTION, CRITICAL, DANGER, SECURITY
# BUG, DEPRECATED, FIXME, HACK, TASK, TBD, TODO, WARNING
# INFO, NOTE, NOTICE, TEST, TESTING

extends Node

# Настройки и служебное
var VERSION = ProjectSettings.get_setting("application/config/version")
var FULLSCREEN = false
var SmoothTransitions = false
@onready var GAME = "res://gamemode.tscn"
@onready var SETTINGS = "res://settings.tscn"
var FROM = 0

#Конфиги
const SAVE_PATH = "user://save.cfg"
var CONFIG = ConfigFile.new()
var KT_URL = "https://kteam.veliona.no/"

# Переменные
var BGID
var ZCOINS = 0
var CURRENT_AIM = preload("res://Resources/aims/default.png")


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
	if !CONFIG.get_value("settings", "lang"):
		TranslationServer.set_locale("en")
	else:
		TranslationServer.set_locale(CONFIG.get_value("settings", "lang"))
		
	if CONFIG.get_value("settings", "smoothtransitions"):
		SmoothTransitions = CONFIG.get_value("settings", "smoothtransitions")
	
		
	if CONFIG.get_value("settings", "fullscreen"):
		DisplayServer.window_set_mode(DisplayServer.WINDOW_MODE_FULLSCREEN)
		FULLSCREEN = CONFIG.get_value("settings", "fullscreen")	
		
	if CONFIG.get_value("save", "zcoins"):
		ZCOINS = CONFIG.get_value("save", "zcoins")
		
		
		
# полезная функция™
func check(в_рот_мне_ноги: bool):
	if в_рот_мне_ноги:
		return true
	else:
		return false
		
func got_finishedsign(value):
	match value:
		1:
			await get_tree().process_frame
			get_tree().change_scene_to_file(GAME)
		2:
			await get_tree().process_frame
			get_tree().change_scene_to_file(SETTINGS)
		3:
			await get_tree().process_frame
			get_tree().change_scene_to_file("res://mods.tscn")
		4:
			
			get_tree().quit()
		5:
			await get_tree().process_frame
			get_tree().change_scene_to_file("res://modsinternet.tscn")
		6:
			await get_tree().process_frame
			get_tree().change_scene_to_file("res://menu.tscn")
