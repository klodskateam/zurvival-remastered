extends Timer

const ZONDRE = preload("res://zondre.tscn")

func _on_timeout() -> void:
	wait_time = randf_range(2.5, 5)
	var zondrenew = ZONDRE.instantiate()
	zondrenew.position = $"..".position
	get_parent().get_parent().add_child(zondrenew)
