extends ColorRect

func _ready() -> void:
	if GamemodeManager.GAMEMODE == -1 and GamemodeManager.MODGAME["dark"]:
		visible = true
	else:
		visible = false
	pass
