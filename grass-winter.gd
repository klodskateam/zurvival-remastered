extends Sprite2D

func _ready():
	var time = Time.get_datetime_dict_from_system()
	var month = time["month"]
	if (GamemodeManager.GAMEMODE == -1 and GamemodeManager.MODGAME["force_snow"]) or (GamemodeManager.GAMEMODE != -1 and month >= 12 or month <= 01) or (GamemodeManager.GAMEMODE == -1 and GamemodeManager.MODGAME["snowinwinter"] and month >= 12 or month <= 01):
		texture = load("res://Resources/snow.png")
	else:
		pass
