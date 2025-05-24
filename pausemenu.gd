extends Button

@onready var player = $"/root/game/player"

func _on_pressed() -> void:
	get_tree().paused = false
	Global.ZCOINS += (player.SCORE/4)
	Global.CONFIG.set_value("save", "zcoins", Global.ZCOINS)
	Global.CONFIG.save(Global.SAVE_PATH)
	get_tree().change_scene_to_file("res://menu.tscn")
