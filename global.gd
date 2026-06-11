# TODO
# [1/2] Доделать прицелы
# [*] Сделать кнопки открытия сайта мода в списке модов
# [*] Добавить больше режимов в игру
# [1/4] Доделать магазин и инвентарь (склад)
# [*] Добавить режимы в модлоадер
# [-] Вернуть Discord Rich Preference (или как его) из 1.3 и ниже
# [*] добавьте больше TODO🤪🤪🤪 
# [ ] добавить автомобильный режим
# [ ] сделать ЕЩЁ больше TODO tm
# [ ] Добавить дешёвый блюр 

# INFO самые важные песни зр 2.0 это:
# бутырка метеорит
# бутырка икона
# михаил круг исповедь

# чтооо годот подсветка комментариев😨
# ALERT, ATTENTION, CAUTION, CRITICAL, DANGER, SECURITY
# BUG, DEPRECATED, FIXME, HACK, TASK, TBD, TODO, WARNING
# INFO, NOTE, NOTICE, TEST, TESTING

extends Node

# Настройки и служебное
var VERSION = ProjectSettings.get_setting("application/config/version")
var FULLSCREEN = false
var SmoothTransitions = false
var WEAPONHINTS = true
var CheapEffects = false
@onready var GAME = "res://gamemode.tscn"
@onready var SETTINGS = "res://settings.tscn"
const isDEMO = true # Данная настройка отключает магазин, склад и список модов Онлайн, так-как оно не готово (онлайн моды я ещё апи не сделал ну я и лох вообще)
var devMode = false

#Конфиги
const SAVE_PATH = "user://save.cfg"
var CONFIG = ConfigFile.new()
var KT_URL = "https://kteam.veliona.no/"
var WEAPONS = [
	{
		"name": "$starterpistol",
		"id": 1,
		"class": "sidearm",
		"delay": 1,
		"damage": 100,
		"bullet_speed": 1450,
		"automatic": false,
		"bullets": 12,
		"left_bullets": 12,
		"zapas_bullets": 48,
		"icon": "res://Resources/ui_stuff_lol/weapon_starterpistol.png",
		"incremental_reload": false,
		"increment_sound": "res://Sound/shotgun_increment",
		"incremental_minusroundonreload": false,
		"increment_delay": 0,
		"harmless": false,
		"type": "gun",
		"sway": 0.07,
		"weight": 0.26,
		"shake": 6,
		"soundondelay": false,
		"penthrough": false,
		"bulletdespawn_dist": 900,
		"delaysound": "res://Sound/shotgun_cycle.wav",
		"sound": "res://Sound/pistol.wav",
		"reloadsound": "res://Sound/pistol-reload.wav",
		"weaponswitch_sound": "res://Sound/weaponswitch_light",
		"layered_shootsounds": false,
		"scope": false,
	},
	{
		"name": "$startermp",
		"id": 2,
		"class": "primary",
		"delay": 0.35,
		"damage": 50,
		"bullet_speed": 1450,
		"automatic": true,
		"bullets": 30,
		"left_bullets": 30,
		"zapas_bullets": 60,
		"icon": "res://Resources/ui_stuff_lol/weapon_startermp.png",
		"incremental_reload": false,
		"increment_sound": "res://Sound/shotgun_increment",
		"incremental_minusroundonreload": false,
		"increment_delay": 0,
		"harmless": false,
		"type": "gun",
		"sway": 0.06,
		"weight": 0.34,
		"shake": 8,
		"soundondelay": false,
		"penthrough": false,
		"bulletdespawn_dist": 1200,
		"delaysound": "res://Sound/shotgun_cycle.wav",
		"sound": "res://Sound/pistol-03.wav",
		"reloadsound": "res://Sound/pistol-reload.wav",
		"weaponswitch_sound": "res://Sound/weaponswitch_medium",
		"layered_shootsounds": true,
		"shootlayer_1": "res://Sound/mp5_main",
		"shootlayer_2": "res://Sound/mp5_tail",
		"shootlayer_3": "res://Sound/mp5_click",
		"scope": false,
	},
	{
		"name": "$hegrenade",
		"id": 3,
		"class": "utility",
		"delay": 1,
		"damage": 100,
		"bullet_speed": 1450,
		"automatic": false,
		"bullets": 1,
		"left_bullets": 1,
		"zapas_bullets": 4,
		"icon": "res://Resources/ui_stuff_lol/weapon_hegrenade.png",
		"incremental_reload": false,
		"increment_sound": "res://Sound/shotgun_increment",
		"incremental_minusroundonreload": false,
		"increment_delay": 0,
		"harmless": false,
		"type": "grenade",
		"sway": 0,
		"weight": 0.08,
		"penthrough": false,
		"bulletdespawn_dist": 1000,
		"soundondelay": false,
		"delaysound": "res://Sound/shotgun_cycle.wav",
		"sound": "",
		"reloadsound": "res://Sound/pickup_01.wav",
		"weaponswitch_sound": "res://Sound/weaponswitch_light",
		"layered_shootsounds": false,
		"scope": false,
	},
	{
		"name": "$basicshotgun",
		"id": 4,
		"class": "primary",
		"delay": 2.5,
		"damage": 100,
		"bullet_speed": 1550,
		"automatic": false,
		"bullets": 6,
		"left_bullets": 6,
		"zapas_bullets": 24,
		"icon": "res://Resources/ui_stuff_lol/weapon_basicshotgun.png",
		"incremental_reload": true,
		"increment_sound": "res://Sound/shotgun_increment",
		"incremental_minusroundonreload": false,
		"increment_delay": 0.35,
		"harmless": false,
		"type": "shotgun",
		"sway": 0.15,
		"weight": 0.37,
		"penthrough": false, # у ~~дробовика отдельный код для этого, мб стоит убрать~~ ладно я просто реюзанул код
		"bulletdespawn_dist": 700,
		"shake": 15,
		"soundondelay": true,
		"delaysound": "res://Sound/shotgun_cycle.wav",
		"sound": "res://Sound/shotgun.wav",
		"reloadsound": "res://Sound/pistol-reload.wav",
		"weaponswitch_sound": "res://Sound/weaponswitch_medium",
		"layered_shootsounds": false,
		"scope": false,
	},
	{
		"name": "$highcal_atrifle",
		"id": 5,
		"class": "primary",
		"delay": 3,
		"damage": 300, # выбор трактористов!
		"bullet_speed": 2050,
		"automatic": false,
		"bullets": 5,
		"left_bullets": 5,
		"zapas_bullets": 20,
		"icon": "res://Resources/ui_stuff_lol/weapon_highcalrifle.png",
		"incremental_reload": false,
		"increment_sound": "res://Sound/shotgun_increment",
		"incremental_minusroundonreload": false,
		"increment_delay": 0,
		"harmless": false,
		"type": "gun",
		"sway": 0.12,
		"shake": 45,
		"weight": 0.46,
		"penthrough": true,
		"bulletdespawn_dist": 1600,
		"soundondelay": false,
		"delaysound": "res://Sound/shotgun_cycle.wav",
		"sound": "res://Sound/highcal-gun.wav",
		"reloadsound": "res://Sound/highcal-reload.wav",
		"weaponswitch_sound": "res://Sound/weaponswitch_heavy",
		"layered_shootsounds": false,
		"scope": false,
	},
	{
		"name": "$sarifle",
		"id": 6,
		"class": "primary",
		"delay": 1.7,
		"damage": 200,
		"bullet_speed": 2050,
		"automatic": false,
		"bullets": 10,
		"left_bullets": 10,
		"zapas_bullets": 50,
		"icon": "res://Resources/ui_stuff_lol/weapon_sarifle.png",
		"incremental_reload": false,
		"increment_sound": "res://Sound/shotgun_increment",
		"incremental_minusroundonreload": false,
		"increment_delay": 0.38,
		"harmless": false,
		"type": "gun",
		"sway": 0.04,
		"shake": 12,
		"weight": 0.31,
		"penthrough": false,
		"bulletdespawn_dist": 2000,
		"soundondelay": false,
		"delaysound": "res://Sound/shotgun_cycle.wav",
		"sound": "res://Sound/sarifle.wav",
		"reloadsound": "res://Sound/sarifle-reload.wav",
		"weaponswitch_sound": "res://Sound/weaponswitch_medium",
		"layered_shootsounds": false,
		"scope": true,
		"scope_maxzoom": 2, # 1x = 300px
		#"scope_focuswidth": 50,
	},
	{
		"name": "$binoculars",
		"id": 7,
		"class": "utility",
		"delay": 0,
		"damage": 0,
		"bullet_speed": 0,
		"automatic": false,
		"bullets": 0,
		"left_bullets": 0,
		"zapas_bullets": 0,
		"icon": "res://Resources/ui_stuff_lol/weapon_binoculars.png",
		"incremental_reload": false,
		"increment_sound": "res://Sound/shotgun_increment",
		"incremental_minusroundonreload": false,
		"increment_delay": 0,
		"harmless": true,
		"type": "",
		"sway": 0,
		"shake": 0,
		"weight": 0.28,
		"penthrough": false,
		"bulletdespawn_dist": 0,
		"soundondelay": false,
		"delaysound": "res://Sound/shotgun_cycle.wav",
		"sound": "",
		"reloadsound": "",
		"weaponswitch_sound": "res://Sound/weaponswitch_light",
		"layered_shootsounds": false,
		"scope": true,
		"scope_maxzoom": 3,
		#"scope_focuswidth": 50,
	},
]
var ALLWEAPONS = []
var SAVED_WEAPONS = []
var EQUIPPED_WEAPONS = []


# Переменные
var BGID
var FROM = 0
var ZCOINS = 0
var CURRENT_AIM = preload("res://Resources/aims/default.png")
var GAYPAD_AIDS = 1 # причем тут aids? ну, типа короче типа я хотел сначала gaypad_speed, ну типа спид, а спид по английски это aids вот типа шутка да хазвъзахвзахвзахвза
var CONTROLLER_CONNECTED = false
var weap_chng_btn

func _input(event: InputEvent) -> void:
	if event.is_action_pressed("fullscreenkey"):
		if FULLSCREEN == false:
			DisplayServer.window_set_mode(DisplayServer.WINDOW_MODE_FULLSCREEN)
			FULLSCREEN = true
		else:
			DisplayServer.window_set_mode(DisplayServer.WINDOW_MODE_WINDOWED)
			FULLSCREEN = false
	if event.is_action_pressed("devToggle"):
		devMode = !devMode
		CONFIG.set_value("developer", "enabled", devMode)
		CONFIG.save(SAVE_PATH)
		OS.alert("DevMode Enabled: " + str(devMode))
			
			
	
func _ready() -> void:
	CONFIG.load(SAVE_PATH)
	
	ALLWEAPONS = []	
	for i in WEAPONS.size():
		var saveweaponarray = {"id": WEAPONS[i]["id"], "class": WEAPONS[i]["class"]}
		ALLWEAPONS.append(saveweaponarray)	
	if !CONFIG.get_value("settings", "lang"):
		TranslationServer.set_locale("en")
	else:
		TranslationServer.set_locale(CONFIG.get_value("settings", "lang"))
		
	if CONFIG.get_value("settings", "smoothtransitions"):
		SmoothTransitions = CONFIG.get_value("settings", "smoothtransitions")
	
	if CONFIG.get_value("save", "disableweaponhints"):
		WEAPONHINTS = CONFIG.get_value("save", "disableweaponhints")
		
	if CONFIG.get_value("settings", "fullscreen"):
		DisplayServer.window_set_mode(DisplayServer.WINDOW_MODE_FULLSCREEN)
		FULLSCREEN = CONFIG.get_value("settings", "fullscreen")
		
	if CONFIG.get_value("settings", "gamepad_sens"):
		GAYPAD_AIDS = CONFIG.get_value("settings", "gamepad_sens")
		
	if CONFIG.get_value("save", "zcoins"):
		ZCOINS = CONFIG.get_value("save", "zcoins")
		
	if CONFIG.get_value("items", "weapons"):
		SAVED_WEAPONS = CONFIG.get_value("items", "weapons")
	else:
		SAVED_WEAPONS.append(ALLWEAPONS[0])
		
	for weapon in SAVED_WEAPONS.size():
		for allweapons in WEAPONS.size():
			if SAVED_WEAPONS[weapon]["id"] == WEAPONS[allweapons]["id"]:
				#print("yeee" + str(weapon)+ " " + str(allweapons))
				EQUIPPED_WEAPONS.append(WEAPONS[allweapons])
	
	devMode = CONFIG.get_value("developer", "enabled", false)
	# tf2 reference ALERT
	# NOTE: я скомпилированную игру не могу запустить, надо закомментировать rsiughdsugjh
#	if !FileAccess.file_exists("res://_IMPORTANT_IMAGE_DONT_DELETE_INACHE_PISEC!!.jpg"):
#		OS.alert("Игра обнаружила отсутствие самого важного файла. Игра больше не запустится. Наверное.\nВерните файл на место и не трогайте его ему страшно вообще капец.", "Aw, snap")
#		OS.crash("Fatal error")
		

# полезная функция™
func check(в_рот_мне_ноги: bool):
	if в_рот_мне_ноги:
		return true
	else:
		return false
		
func got_finishedsign(value):
	# ID которое используется для определения, в какую сцену отправить после анимации. Пока-что работают только встроенные анимации/сцены.
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
