extends Timer

const ZONDRE = preload("res://zondre.tscn")

func _on_timeout() -> void:
	wait_time = randf_range(2.5, 5)
	if GamemodeManager.GAMEMODE == -1 and GamemodeManager.MODGAME["zondre_donotspawn"]:
		pass
	else:
		var zondrenew = ZONDRE.instantiate()
		zondrenew.position = $"..".position
		get_parent().get_parent().add_child(zondrenew)
