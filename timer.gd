extends Timer
const P_MEDKIT = preload("res://medkit.tscn")
const P_BULLETS = preload("res://bullets.tscn")

func _on_timeout():
	wait_time = randf_range(1, 2)
	# пульки хуюльки
	if randi_range(1, 2) == 1:
		var bullets_new = P_BULLETS.instantiate()
		bullets_new.position.x = randi_range(50, 9950)
		bullets_new.position.y = randi_range(50, 9950)
		get_parent().add_child(bullets_new)
		print(bullets_new)
	# аптечки
	if randi_range(1, 2) == 1:
		var medkit_new = P_MEDKIT.instantiate()
		medkit_new.position.x = randi_range(50, 9950)
		medkit_new.position.y = randi_range(50, 9950)
		get_parent().add_child(medkit_new)
		print(medkit_new)
	
