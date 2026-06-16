extends Timer

const ZONDRE = preload("res://zondre.tscn")
var rngnum = 0
var rngnum2 = 0
 
func _on_timeout() -> void:
	if GamemodeManager.GAMEMODE == 3:
		var DATE = Time.get_date_string_from_system()
		var RNG = RandomNumberGenerator.new()
		var RNG2 = RandomNumberGenerator.new()
		DATE = int(str(DATE).replace("-", ""))
		#print("date:" + str(hash(int(DATE/64))))
		if GamemodeManager.CHALLENGEID == 0:
			RNG.seed = hash(DATE^6489)
		elif GamemodeManager.CHALLENGEID == 1:
			RNG.seed = hash(DATE^563)
		elif GamemodeManager.CHALLENGEID == 2:
			RNG.seed = hash(DATE^9173)
		rngnum = RNG.randi_range(0, 19)
		rngnum2 = RNG.randi_range(0,6)
		if rngnum == 16 or rngnum2 == 4:
			wait_time = randf_range(1.4, 3.8)
	elif GamemodeManager.GAMEMODE != 3 or rngnum != 16:
		wait_time = randf_range(2.5, 5)			
		
	if GamemodeManager.GAMEMODE == -1 and GamemodeManager.MODGAME["zondre_donotspawn"]:
		pass
	else:
		pass
		var zondrenew = ZONDRE.instantiate()
		zondrenew.position = $"..".position
		get_parent().get_parent().add_child(zondrenew)
