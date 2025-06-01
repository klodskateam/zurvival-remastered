# TODO
# [1/2] Доделать прицелы
# [*] Сделать кнопки открытия сайта мода в списке модов
# [ ] Добавить больше режимов в игру
# [ ] Доделать магазин и инвентарь (склад)
# [ ] Добавить режимы в модлоадер
# [ ] Вернуть Discord Rich Preference (или как его) из 1.3 и ниже
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

#Конфиги
const SAVE_PATH = "user://save.cfg"
var CONFIG = ConfigFile.new()
var KT_URL = "https://kteam.veliona.no/"

# Переменные
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
	
	if CONFIG.get_value("settings", "fullscreen") == true:
		DisplayServer.window_set_mode(DisplayServer.WINDOW_MODE_FULLSCREEN)
		
	if CONFIG.get_value("save", "zcoins"):
		ZCOINS = CONFIG.get_value("save", "zcoins")
	if CONFIG.get_value("save", "fullscreen"):
		FULLSCREEN = CONFIG.get_value("save", "fullscreen")
		

		
# полезная функция™
func check(в_рот_мне_ноги: bool):
	if в_рот_мне_ноги:
		return true
	else:
		return false
		
