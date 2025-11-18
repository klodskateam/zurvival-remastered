extends Timer
const P_MEDKIT = preload("res://medkit.tscn")
const P_BULLETS = preload("res://bullets.tscn")
const P_PLANK = preload("res://plank.tscn")

func _on_timeout():
	match GamemodeManager.GAMEMODE:
		1:
			pass
		2:
			wait_time = randf_range(1, 1.7)
			# пульки хуюльки
			var bullets_new = P_BULLETS.instantiate()
			bullets_new.position.x = randi_range(250, 4200)
			bullets_new.position.y = randi_range(250, 4350)
			get_parent().add_child(bullets_new)
			print(bullets_new)
			
			# оптечки
			var medkit_new = P_MEDKIT.instantiate()
			medkit_new.position.x = randi_range(50, 9950)
			medkit_new.position.y = randi_range(50, 9950)
			get_parent().add_child(medkit_new)
			print(medkit_new)
			
			# доски, я хз где мы их нашли, у меня альцгеймер
			var plank_new = P_PLANK.instantiate()
			plank_new.position.x = randi_range(500, 3800)
			plank_new.position.y = randi_range(500, 3850)
			get_parent().add_child(plank_new)
			print(plank_new)
		_:
			wait_time = randf_range(0.01, 0.01)
			# пульки хуюльки
			var bullets_new = P_BULLETS.instantiate()
			bullets_new.position.x = randi_range(50, 9950)
			bullets_new.position.y = randi_range(50, 9950)
			get_parent().add_child(bullets_new)
			print(bullets_new)
			
			# оптечки
			var medkit_new = P_MEDKIT.instantiate()
			medkit_new.position.x = randi_range(50, 9950)
			medkit_new.position.y = randi_range(50, 9950)
			get_parent().add_child(medkit_new)
			print(medkit_new)

	
