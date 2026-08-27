extends Timer
const P_MEDKIT = preload("res://medkit.tscn")
const P_BULLETS = preload("res://bullets.tscn")
const P_PLANK = preload("res://plank.tscn")
var rngnum
var medkitsbanned = false

func _ready() -> void:
	if GamemodeManager.GAMEMODE == 3:
		# богато!
		var DATE = Time.get_date_string_from_system()
		var RNG = RandomNumberGenerator.new()
		DATE = int(str(DATE).replace("-", ""))
		#print("date:" + str(hash(int(DATE/64))))
		if GamemodeManager.CHALLENGEID == 0:
			RNG.seed = hash(DATE^ChallengeManager.CHALLENGES[0]["xorhash"])
		elif GamemodeManager.CHALLENGEID == 1:
			RNG.seed = hash(DATE^ChallengeManager.CHALLENGES[1]["xorhash"])
		elif GamemodeManager.CHALLENGEID == 2:
			RNG.seed = hash(DATE^ChallengeManager.CHALLENGES[2]["xorhash"])
		rngnum = RNG.randi_range(0, 12)
		if rngnum == 2:
			medkitsbanned = true
func _on_timeout():
	match GamemodeManager.GAMEMODE:
		-1:
			wait_time = randf_range(1, 2)
			# пульки хуюльки
			if GamemodeManager.MODGAME["spawn_bullets"]:
				var bullets_new = P_BULLETS.instantiate()
				bullets_new.position.x = randi_range(50, 9950)
				bullets_new.position.y = randi_range(50, 9950)
				get_parent().add_child(bullets_new)
				#print(bullets_new)
			if GamemodeManager.MODGAME["spawn_medkits"]:
				# оптечки
				var medkit_new = P_MEDKIT.instantiate()
				medkit_new.position.x = randi_range(50, 9950)
				medkit_new.position.y = randi_range(50, 9950)
				get_parent().add_child(medkit_new)
				#print(medkit_new)
		1:
			pass
		2:
			wait_time = randf_range(1, 1.7)
			# пульки хуюльки
			var bullets_new = P_BULLETS.instantiate()
			bullets_new.position.x = randi_range(250, 4200)
			bullets_new.position.y = randi_range(250, 4350)
			get_parent().add_child(bullets_new)
			#print(bullets_new)
			
			# оптечки
			var medkit_new = P_MEDKIT.instantiate()
			medkit_new.position.x = randi_range(50, 9950)
			medkit_new.position.y = randi_range(50, 9950)
			get_parent().add_child(medkit_new)
			#print(medkit_new)
			
			# доски. я хз где мы их нашли, у меня альцгеймер
			var plank_new = P_PLANK.instantiate()
			plank_new.position.x = randi_range(500, 3800)
			plank_new.position.y = randi_range(500, 3850)
			get_parent().add_child(plank_new)
			#print(plank_new)
		3:
			wait_time = randf_range(1, 2)
			# пульки хуюльки
			var bullets_new = P_BULLETS.instantiate()
			bullets_new.position.x = randi_range(50, 9950)
			bullets_new.position.y = randi_range(50, 9950)
			get_parent().add_child(bullets_new)
			#print(bullets_new)
			
			# оптечки
			if medkitsbanned:
				# РКН заблокировал аптечки
				pass
			else:
				var medkit_new = P_MEDKIT.instantiate()
				medkit_new.position.x = randi_range(50, 9950)
				medkit_new.position.y = randi_range(50, 9950)
				get_parent().add_child(medkit_new)
				#print(medkit_new)		
		4:
			wait_time = randf_range(1, 1.7)
			# пульки хуюльки
			var bullets_new = P_BULLETS.instantiate()
			bullets_new.position.x = randi_range(250, 49750)
			bullets_new.position.y = randi_range(250, 49750)
			get_parent().add_child(bullets_new)
			#print(bullets_new)
			
			# оптечки
			var medkit_new = P_MEDKIT.instantiate()
			medkit_new.position.x = randi_range(50, 49950)
			medkit_new.position.y = randi_range(50, 49950)
			get_parent().add_child(medkit_new)
			#print(medkit_new)		
			
		_:
			wait_time = randf_range(1, 2)
			# пульки хуюльки
			var bullets_new = P_BULLETS.instantiate()
			bullets_new.position.x = randi_range(50, 9950)
			bullets_new.position.y = randi_range(50, 9950)
			get_parent().add_child(bullets_new)
			#print(bullets_new)
			
			# оптечки
			var medkit_new = P_MEDKIT.instantiate()
			medkit_new.position.x = randi_range(50, 9950)
			medkit_new.position.y = randi_range(50, 9950)
			get_parent().add_child(medkit_new)
			#print(medkit_new)

	
