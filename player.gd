extends CharacterBody2D

@onready var score: Label = $"../UI/Score"

@onready var kaktameto: Label = $"../UI/SpeedBar/Speed"
@onready var kaktameto_bar: ProgressBar = $"../UI/SpeedBar"

@onready var bullets: Label = $"../UI/BulletsBar/Bullets"
@onready var bullets_bar: ProgressBar = $"../UI/BulletsBar"

@onready var health: Label = $"../UI/HealthBar/Health"
@onready var health_bar: ProgressBar = $"../UI/HealthBar"

@onready var inventory: Label = $"../UI/InventoryBar/Inventory"
@onready var inventory_bar: ProgressBar = $"../UI/InventoryBar"

@onready var coldness: Label = $"../UI/ColdnessBar/Coldness"
@onready var coldness_bar: ProgressBar = $"../UI/ColdnessBar"

@onready var weapon_text: Label = $"../UI/WeaponText"
@onready var weapon_icon: Sprite2D = $"../UI/WeaponText/WeaponIcon"

@onready var vignette_red = $"../UI/VignetteRed"
@onready var damageblur = $"../UI/DMGBlur"

const PICKUP_01 = preload("res://Sound/pickup_01.wav")
const PICKUP_02 = preload("res://Sound/pickup_02.wav")
const PICKUP_MEDKIT_01 = preload("res://Sound/pickup_medkit_01.wav")
const PICKUP_MEDKIT_02 = preload("res://Sound/pickup_medkit_02.wav")
var GRENADE_PREPARE = preload("uid://brrx5ku6x7b1n")

var unreliableweapon = false
var RELOADING = false
var time = Time.get_datetime_dict_from_system()
var month = time["month"]
var HINT_TWEEN : Tween
var VINOSLIVOST = 100
@export var MAX_VINOSLIVOST = 100
var pickedup : bool = false
var pickedup_medkit : bool = false
var pickedup_plank : bool = false
var SPEED = 325
var DELAY = 0
var HEALTH = 100
var COLDNESS = 0
var INVENTORY_FILLED = 0
@export var MAX_INVENTORY_FILLED = 100
@export var MAX_COLDNESS = 100
@export var MAX_HEALTH = 100
var SCORE = 0
var RUNLOCK = 0
var INCREMENT_DELAY = 0
var ogroundamount = 0
var maybeselectedweapon = 0
var FORCE_RUNLOCK = false
var shake = false
var zondrespleasesaveusall = false
var weightaccum = 0
var accum2 = 0
var dmgblur = false
var ZOOMING = false
@export var ded: bool = false

@export var REGULAR_SPEED = 300
@export var RUN_SPEED = 410
@export var P_BULLET = preload("res://bullet.tscn")
@export var P_GRENADE = preload("uid://c52nnfwncwkti")
@onready var grenade_target: Marker2D = $GrenadeTarget
@export var max_range = 420
var max_range2 = 0
var inthehall = false
var steptimer = 0
var stepmaterial = "grass"
var dir2 = Vector2()

var shakeamount = 0
var shaketimer = 0
var shakedelay = 0.07
var weaponshakeamount = 0
var fastshakeamount = 0
var totalshakeamount = 0

var driving = false

@export var SELECTED_WEAPON = 0

var WEAPONS = []

func _ready() -> void:
	WEAPONS = Global.EQUIPPED_WEAPONS.duplicate(true)
	if Global.CheapEffects:
		damageblur.material.set_shader_parameter("blur_type", 6)
	else:
		damageblur.material.set_shader_parameter("blur_type", 2)
	if get_node_or_null("../snow") != null or GamemodeManager.GAMEMODE == 2 or (GamemodeManager.GAMEMODE == -1 and GamemodeManager.MODGAME["force_snow"]) or (GamemodeManager.GAMEMODE == -1 and GamemodeManager.MODGAME["snowinwinter"] and (month >= 12 or month <= 01)) or ((GamemodeManager.GAMEMODE != -1 and GamemodeManager.GAMEMODE != 2)  and (month >= 12 or month <= 01)):
		stepmaterial = "snow"
	else:
		stepmaterial = "grass"
	if GamemodeManager.GAMEMODE == 1 or (GamemodeManager.GAMEMODE == -1 and !GamemodeManager.MODGAME["allow_weapons"]):
		WEAPONS = []
		WEAPONS.append(Global.WEAPONS[0])
		WEAPONS[0]["sway"] = 0
		WEAPONS[0]["shake"] = 0
		WEAPONS[0]["bulletdespawn_dist"] = 10000
	if GamemodeManager.GAMEMODE == -1:
		print("forcesnow: " + str(GamemodeManager.MODGAME["force_snow"]))
		print("snowinwinter: " + str(GamemodeManager.MODGAME["snowinwinter"]))
		if !GamemodeManager.MODGAME.has("player_health") or GamemodeManager.MODGAME["player_health"] == "default":
			HEALTH = MAX_HEALTH
		else:
			MAX_HEALTH = int(GamemodeManager.MODGAME["player_health"])
			health_bar.max_value = int(GamemodeManager.MODGAME["player_health"])
			HEALTH = int(GamemodeManager.MODGAME["player_health"])
	if GamemodeManager.GAMEMODE == 3:
		# весело
		var DATE = Time.get_date_string_from_system()
		var RNG = RandomNumberGenerator.new()
		var RNG2 = RandomNumberGenerator.new()
		DATE = int(str(DATE).replace("-", ""))
		#print("date:" + str(hash(int(DATE/64))))
		if GamemodeManager.CHALLENGEID == 0:
			RNG.seed = hash(DATE^65454)
		elif GamemodeManager.CHALLENGEID == 1:
			RNG.seed = hash(DATE^23775)
		elif GamemodeManager.CHALLENGEID == 2:
			RNG.seed = hash(DATE^85263)
		var rngnum = RNG.randi_range(0, 10)
		var rngnum2 = RNG.randi_range(0, 14)
		var rngnum3 = RNG.randi_range(0, 23)
		var rngnum4 = RNG.randi_range(0, 18)
		#print(rngnum)
		#print(rngnum2)
		#print(rngnum3)
		
		if rngnum == 5:
			REGULAR_SPEED = 200
			RUN_SPEED = 335
		elif rngnum == 9:
			REGULAR_SPEED = 250
			RUN_SPEED = 375	
		if rngnum2 == 7 or rngnum4 == 3:
			WEAPONS = []
			WEAPONS.append(Global.WEAPONS[0].duplicate(true))
			WEAPONS[0]["sway"] = 0
			WEAPONS[0]["shake"] = 0
			WEAPONS[0]["bulletdespawn_dist"] = 10000
			WEAPONS[0]["sound"] = "res://Sound/pistol-02.wav"
			WEAPONS[0]["damage"] = 200
			WEAPONS[0]["bullets"] = 1
			WEAPONS[0]["left_bullets"] = 1
			WEAPONS[0]["zapas_bullets"] = 40
		elif rngnum2 == 9 or rngnum4 == 12:
			WEAPONS = []
			WEAPONS.append(Global.WEAPONS[2].duplicate(true))
			WEAPONS[0]["zapas_bullets"] = 16
		elif rngnum2 == 5 or rngnum2 == 8:
			for weapon in WEAPONS.size():
				WEAPONS[weapon]["delay"] *= 3
		elif rngnum2 == 3:
			for weapon in WEAPONS.size():
				WEAPONS[weapon]["incremental_reload"] = true
				WEAPONS[weapon]["increment_delay"] = 0.4
		elif rngnum2 == 12 or rngnum4 == 8:
			unreliableweapon = true
		if rngnum3 == 15 or rngnum4 == 6:
			MAX_HEALTH = 60
			health_bar.max_value = 60
			HEALTH = 60
		elif rngnum3 == 18 or rngnum4 == 2:
			MAX_HEALTH = 80
			health_bar.max_value = 80
			HEALTH = 80
		elif rngnum3 == 7: # совсем плохо
			MAX_HEALTH = 40
			health_bar.max_value = 40
			HEALTH = 40	
		if rngnum4 == 11:
			FORCE_RUNLOCK = true
	
	match GamemodeManager.GAMEMODE:
		2:
			pass
		1:
			if health_bar:
				health_bar.queue_free()
			if kaktameto_bar:
				kaktameto_bar.queue_free()
			if inventory_bar:
				inventory_bar.queue_free()
			if coldness_bar:
				coldness_bar.queue_free()
			bullets_bar.position = Vector2(30, 3)
		_:
			if inventory_bar:
				inventory_bar.queue_free()
			if coldness_bar:
				coldness_bar.queue_free()
	for weapon in WEAPONS.size():
		weightaccum += WEAPONS[weapon]["weight"]
	
	weaponhint_show()

func _physics_process(delta: float):
	#TranslationServer.set_locale("be")
	var direction = get_input()
	if !driving:
		if direction.length() > 0:
			if Input.is_action_pressed("run") and (Input.is_action_pressed("up") or Input.is_action_pressed("down") or Input.is_action_pressed("left") or Input.is_action_pressed("right")) and RUNLOCK != 1:
				dir2 = direction.lerp(direction.normalized(), 0.9)
			else:
				dir2 = direction.lerp(direction.normalized(), 0.35)
			velocity = velocity.lerp(dir2 * SPEED, 0.3)
		else:
			velocity = velocity.lerp(Vector2.ZERO, 0.2)
		move_and_slide()	
	
	score.text = str(SCORE)
	
	if ZOOMING:
		$ZoomTarget.position = lerp($ZoomTarget.position, get_local_mouse_position(), 0.5)
		if Vector2.ZERO.distance_to($ZoomTarget.position) >= WEAPONS[SELECTED_WEAPON]["scope_maxzoom"]*300: # беги щас тракторист тебя застрелит
			pass
		else:
			if get_local_mouse_position().length() <= 100:
				$Camera2D.position = $Camera2D.position.lerp($ZoomTarget.position, 0.02)
			else:
				$Camera2D.position = $Camera2D.position.lerp($ZoomTarget.position, 0.04)
		
		#var scopeidk = (WEAPONS[SELECTED_WEAPON]["scope_focuswidth"])**4/(Vector2.ZERO.distance_to($ZoomTarget.position)**2)
		#$SubViewport/Polygon2D.polygon[1].x = clamp(-scopeidk, -70, 0)
		#$SubViewport/Polygon2D.polygon[2].x = clamp(scopeidk, 0, 70)
	
		#$SubViewport/Polygon2D.polygon[1].y = -Vector2.ZERO.distance_to($ZoomTarget.position)
		#$SubViewport/Polygon2D.polygon[2].y = -Vector2.ZERO.distance_to($ZoomTarget.position)
		#$SubViewport/Camera2D.position = $Camera2D.position
	else:
		$Camera2D.position = Vector2.ZERO
	
	if kaktameto_bar:
		kaktameto.text = tr("$stamina") + ": " + str(round(int(VINOSLIVOST))) + "/" + str(MAX_VINOSLIVOST)
		kaktameto_bar.max_value = MAX_VINOSLIVOST
		kaktameto_bar.value = VINOSLIVOST
	else:
		pass
	match GamemodeManager.GAMEMODE:
		1:
			bullets.text = tr("$bullets") + ": " + str(WEAPONS[SELECTED_WEAPON]["left_bullets"])
			bullets_bar.max_value = WEAPONS[SELECTED_WEAPON]["bullets"]
			bullets_bar.value = WEAPONS[SELECTED_WEAPON]["left_bullets"]
		_:	
			bullets.text = tr("$bullets") + ": " + str(WEAPONS[SELECTED_WEAPON]["left_bullets"]) + "/" + str(WEAPONS[SELECTED_WEAPON]["zapas_bullets"])
			bullets_bar.max_value = WEAPONS[SELECTED_WEAPON]["bullets"]
			bullets_bar.value = WEAPONS[SELECTED_WEAPON]["left_bullets"]
	
	if health_bar:
		health.text = tr("$health") + ": " + str(HEALTH) + "/" + str(MAX_HEALTH)
		health_bar.max_value = MAX_HEALTH
		health_bar.value = HEALTH
	else:
		pass
		
	if inventory_bar:
		inventory.text = tr("$inventory") + ": " + str(INVENTORY_FILLED) + "/" + str(MAX_INVENTORY_FILLED)
		inventory_bar.max_value = MAX_INVENTORY_FILLED
		inventory_bar.value = INVENTORY_FILLED
	else:
		pass
	
	if coldness_bar:
		coldness.text = tr("$coldness") + ": " + str(COLDNESS) + "/" + str(MAX_COLDNESS)
		coldness_bar.max_value = MAX_COLDNESS
		coldness_bar.value = COLDNESS
	else:
		pass
	
	if RELOADING and WEAPONS[SELECTED_WEAPON]["incremental_reload"]:
		if INCREMENT_DELAY >= WEAPONS[maybeselectedweapon]["increment_delay"]:
			INCREMENT_DELAY = 0
			$ReloadSound.stream = load(str(WEAPONS[maybeselectedweapon]["increment_sound"] + "_" + str(randi_range(1,5)).pad_zeros(2)) + ".wav")
			$ReloadSound.pitch_scale = randf_range(0.92, 1.04)
			$ReloadSound.play()
			WEAPONS[maybeselectedweapon]["left_bullets"] += 1
			WEAPONS[maybeselectedweapon]["zapas_bullets"] -= 1
			if WEAPONS[maybeselectedweapon]["zapas_bullets"] <= 0 or WEAPONS[SELECTED_WEAPON]["left_bullets"] == WEAPONS[SELECTED_WEAPON]["bullets"]:
				RELOADING = false
			if WEAPONS[SELECTED_WEAPON]["left_bullets"]	== WEAPONS[SELECTED_WEAPON]["bullets"] and !RELOADING and ogroundamount == 0:
				DELAY = WEAPONS[SELECTED_WEAPON]["delay"]
		
	match GamemodeManager.GAMEMODE:
		1:
			pass
		_:	
			if Input.is_action_pressed("run") and (Input.is_action_pressed("up") or Input.is_action_pressed("down") or Input.is_action_pressed("left") or Input.is_action_pressed("right")) and RUNLOCK != 1:
				if (VINOSLIVOST >= 40):
					SPEED = RUN_SPEED 
					fov_up()
				#	$Camera2D.zoom = Vector2(0.98, 0.98)
				else:
					SPEED = RUN_SPEED - 65
					fov_half_up()
				#	$Camera2D.zoom = Vector2(0.987, 0.987)
				if (VINOSLIVOST >= 0):
					SPEED = RUN_SPEED
					VINOSLIVOST -= (9.5 + (weightaccum**2)*15.6) * delta
				else:
					SPEED = REGULAR_SPEED
					fov_down()
		#			$Camera2D.zoom = Vector2(1, 1)
					RUNLOCK = 1
			else:
				SPEED = REGULAR_SPEED
				if (VINOSLIVOST <= MAX_VINOSLIVOST) and (SPEED != RUN_SPEED):
					VINOSLIVOST += (3.5 / (1+(weightaccum**2)*0.6)) * delta
					fov_down()
		#					$Camera2D.zoom = Vector2(1, 1)
			if (VINOSLIVOST <= 35) and !Input.is_action_pressed("run") or FORCE_RUNLOCK:
				RUNLOCK = 1
			if (VINOSLIVOST >= 35) and !FORCE_RUNLOCK:
				RUNLOCK = 0
		
	match GamemodeManager.GAMEMODE:
		1:
			pass
		2:
			if Input.is_action_pressed("run") and (Input.is_action_pressed("up") or Input.is_action_pressed("down") or Input.is_action_pressed("left") or Input.is_action_pressed("right")) and RUNLOCK != 1:
				SPEED = clamp(RUN_SPEED - ((INVENTORY_FILLED**1.55)/4), 150, 400)
			else:
				SPEED = clamp(REGULAR_SPEED - ((INVENTORY_FILLED**1.65)/4), 150, 400)
		3:
			if Input.is_action_pressed("run") and (Input.is_action_pressed("up") or Input.is_action_pressed("down") or Input.is_action_pressed("left") or Input.is_action_pressed("right")) and RUNLOCK != 1:
				SPEED = clamp(RUN_SPEED - ((INVENTORY_FILLED**1.55)/4), 150, 400)
			else:
				SPEED = clamp(REGULAR_SPEED - ((INVENTORY_FILLED**1.65)/4), 150, 400)
		_:
			pass
	
	if pickedup:
		$Pickup01.pitch_scale = randf_range(0.97, 1.12)
		match randi_range(1,2):
			1:
				$Pickup01.stream = PICKUP_01
			2:
				$Pickup01.stream = PICKUP_02
		$Pickup01.play()
	pickedup = false
	if pickedup_medkit:
		$PickupMedkit01.pitch_scale = randf_range(0.96, 1.12)
		match randi_range(1,2):
			1:
				$PickupMedkit01.stream = PICKUP_MEDKIT_01
			2:
				$PickupMedkit01.stream = PICKUP_MEDKIT_02
		$PickupMedkit01.play()
	pickedup_medkit = false
	if pickedup_plank:
		$Pickup01.pitch_scale = randf_range(0.81, 0.98)
		match randi_range(1,2):
			1:
				$Pickup01.stream = PICKUP_01
			2:
				$Pickup01.stream = PICKUP_02
		$Pickup01.play()
	pickedup_plank = false
	
	if steptimer <= 4:
		steptimer += Vector2(velocity.x, velocity.y).length()/20 * delta
		
	if Vector2(velocity.x, velocity.y).length() > 0:
		if steptimer >= 4:
			$GrassStep01.stream = load("res://Sound/" + stepmaterial + "_step_" + str(randi_range(1,4)).pad_zeros(2) + ".wav")
			$GrassStep01.pitch_scale = randf_range(0.9, 1.06)
			$GrassStep01.play()
			steptimer = 0
		pass
	
	
	damageblur.hp_bluramount = (MAX_HEALTH-HEALTH)/2.3
	if dmgblur:
		damageblur.bluramount += 20
		damageblur.bluramount = clamp(damageblur.bluramount, 0, 60)
		fastshakeamount += 10
		dmgblur = false
		
	if driving:
		$CollisionShape2D.disabled = true
	else:
		$CollisionShape2D.disabled = false
	if (OS.get_name() != "Android") and !driving:
		look_at(get_global_mouse_position())
		rotate(PI / 2)
	else:
		pass
		
	if DELAY <= WEAPONS[SELECTED_WEAPON]["delay"]:
		DELAY += 5.3 * delta
		if DELAY >= WEAPONS[SELECTED_WEAPON]["delay"]/3.4 and WEAPONS[SELECTED_WEAPON]["left_bullets"] > 0 and WEAPONS[SELECTED_WEAPON]["soundondelay"]:
			$ReloadSound.stream = load(WEAPONS[SELECTED_WEAPON]["delaysound"])
			$ReloadSound.pitch_scale = randf_range(0.96, 1.04)
			$ReloadSound.play()
		#print("DELAY:" + str(DELAY))
	if INCREMENT_DELAY <= WEAPONS[SELECTED_WEAPON]["increment_delay"]:
		INCREMENT_DELAY += 1 * delta
	if shaketimer <= shakedelay:
		shaketimer += 1 * delta
	if shakeamount > 0:
		shakeamount = abs(shakeamount)-(19*delta)
	if fastshakeamount > 0:
		fastshakeamount = abs(fastshakeamount)-(40*delta)	
	if weaponshakeamount > 0:
		weaponshakeamount = abs(weaponshakeamount)-(23*delta)

func fov_up():
	var tween = $Camera2D.create_tween()
	tween.parallel().tween_property($Camera2D, "zoom", Vector2(0.907, 0.907), 0.8)
func fov_half_up():
	var tween = $Camera2D.create_tween()
	tween.parallel().tween_property($Camera2D, "zoom", Vector2(0.954, 0.954), 2)
func fov_down():
	var tween = $Camera2D.create_tween()
	tween.parallel().tween_property($Camera2D, "zoom", Vector2(1, 1), 1.4)
func tween_shake():
	var tween = $Camera2D.create_tween()
	tween.parallel().tween_property($Camera2D, "offset", Vector2(0+(randf_range(-1, 1))*totalshakeamount, 0+(randf_range(-1, 1))*totalshakeamount), 0.2).set_trans(Tween.TRANS_SINE)
	

	
func _process(delta: float):
	if (OS.get_name() == "Android"):
		if $"../../GlobalInterface/joysticks/VirtualJoystick2" and $"../../GlobalInterface/joysticks/VirtualJoystick2".is_pressed:
			rotation = $"../../GlobalInterface/joysticks/VirtualJoystick2".output.angle()
			rotate(PI / 2)
	if (HEALTH <= 0) and ($Person != null) or (GamemodeManager.GAMEMODE == 2 and COLDNESS >= MAX_COLDNESS):
		$"../PauseManager".PAUSE = true
		$"../PauseManager".PAUSELOCK = true
		$Person.queue_free()
		$"../GameOver".show()
		Global.ZCOINS += (SCORE/5)
		Global.CONFIG.set_value("save", "zcoins", Global.ZCOINS)
		Global.CONFIG.save(Global.SAVE_PATH)
		$"../GameOver".receivedzc = (SCORE/5)
		$"../GameOver".set_scores()
	if (HEALTH <= 20):
		vignette_red.lowhealth = true
	else:
		vignette_red.lowhealth = false	
		
	#if shake:
		#$Camera2D/AnimationPlayer.play("shake")
		#shake = false
		
	if shaketimer >= shakedelay:
		tween_shake()
		shaketimer = 0	
	shakedelay = 1/(totalshakeamount+10)
	totalshakeamount = shakeamount + weaponshakeamount + fastshakeamount	
	if Input.is_action_pressed("shoot"):
		ratata()	

func ratata():
	if !WEAPONS[SELECTED_WEAPON]["automatic"] or WEAPONS[SELECTED_WEAPON]["type"] == "grenade" or RELOADING:
		return
	if WEAPONS[SELECTED_WEAPON]["left_bullets"] > 0 and DELAY >= WEAPONS[SELECTED_WEAPON]["delay"] and !RELOADING:
		shoot()
	
func _input(event):
	if event.is_action_pressed("shoot") and WEAPONS[SELECTED_WEAPON]["type"] != "grenade" and !WEAPONS[SELECTED_WEAPON]["harmless"]:
		if RELOADING:
			RELOADING = false
		else:
			if (OS.get_name() != "Android"):
				shoot()
			
	if Input.is_action_pressed("shoot") and WEAPONS[SELECTED_WEAPON]["type"] == "grenade":
		grenade_target.global_position = get_global_mouse_position()
		inthehall = true # (-all +ole)
	if Input.is_action_just_pressed("shoot") and WEAPONS[SELECTED_WEAPON]["type"] == "grenade" and WEAPONS[SELECTED_WEAPON]["left_bullets"] > 0:
		$Pickup01.stream = GRENADE_PREPARE
		$Pickup01.pitch_scale = randf_range(0.83, 1.06)
		$Pickup01.play()
	if Input.is_action_just_released("shoot") and inthehall and WEAPONS[SELECTED_WEAPON]["type"] == "grenade" and !WEAPONS[SELECTED_WEAPON]["harmless"]:
		throw()
		pass
	if event.is_action_pressed("ads_zoom") and WEAPONS[SELECTED_WEAPON]["scope"]:
		if ZOOMING:
			ZOOMING = false
		else:
			ZOOMING = true 



	if event.is_action_pressed("reload") and !WEAPONS[SELECTED_WEAPON]["harmless"]:
		bullets_reload()
	
	match GamemodeManager.GAMEMODE:
		-1:
			if GamemodeManager.MODGAME["allow_weapons"]:
			# HACK HACK HACK Самый простой выбор оружия циферками (g)
			# 3.14sd:fearful:c			
				if event.is_pressed() and event is InputEventKey:
					for i in range(10):
						if event.keycode == KEY_0 + i:
							changeweapon(i-1)
							break
				if event.is_action_pressed("nextweapon"):
					if SELECTED_WEAPON + 1 >= WEAPONS.size():
						changeweapon(0)
					else:
						changeweapon(SELECTED_WEAPON+1)
						
				if event.is_action_pressed("previousweapon"):
					if SELECTED_WEAPON - 1 < 0:
						changeweapon(SELECTED_WEAPON-1)
					else:
						changeweapon(0)
			else:
				pass
		1: 
			pass
		_:			
			if event.is_pressed() and event is InputEventKey:
				for i in range(10):
					if event.keycode == KEY_0 + i:
						changeweapon(i-1)
						break
			if event.is_action_pressed("nextweapon"):
				if SELECTED_WEAPON + 1 >= WEAPONS.size():
					changeweapon(0)
				else:
					changeweapon(SELECTED_WEAPON+1)
					
			if event.is_action_pressed("previousweapon"):
				if SELECTED_WEAPON - 1 < 0:
					changeweapon(WEAPONS.size()-1)
				else:
					changeweapon(SELECTED_WEAPON-1)
					
func changeweapon(number: int = 0):
	if number > WEAPONS.size() - 1:
		pass
	else:
		if number != SELECTED_WEAPON:
			$WeaponSwitch.stream = load(str(WEAPONS[number]["weaponswitch_sound"] + "_" + str(randi_range(1,3)).pad_zeros(2)) + ".wav")
			$WeaponSwitch.pitch_scale = randf_range(0.89, 1.07)
			$WeaponSwitch.play()
		SELECTED_WEAPON = number
		weaponhint_show()
		if WEAPONS[SELECTED_WEAPON]["harmless"]:
			bullets_bar.visible = false
		else:
			bullets_bar.visible = true
		RELOADING = false
		ZOOMING = false
		#print(SELECTED_WEAPON)

		
	
func shoot():
	if WEAPONS[SELECTED_WEAPON]["left_bullets"] != 0:
		if DELAY >= WEAPONS[SELECTED_WEAPON]["delay"]:
			# bullet.add_constant_force(get_global_mouse_position() - bullet.global_position)
			if WEAPONS[SELECTED_WEAPON]["type"] == "shotgun":
				#$Camera2D/AnimationPlayer.stop()
				#$Camera2D/AnimationPlayer.play("shotgun_recoil")	
				for i in 9:
					var bullet = P_BULLET.instantiate()
					bullet.shotgunbullet = true
					bullet.global_position = $Marker2D.global_position
					bullet.markerpos = $Marker2D.global_position
					bullet.despawn_dist = WEAPONS[SELECTED_WEAPON]["bulletdespawn_dist"]
					bullet.PIERCETHRU = WEAPONS[SELECTED_WEAPON]["penthrough"]
					bullet.DAMAGE = WEAPONS[SELECTED_WEAPON]["damage"]
					bullet.SPEED = WEAPONS[SELECTED_WEAPON]["bullet_speed"]
					shaketimer = shakedelay+1
					weaponshakeamount = WEAPONS[SELECTED_WEAPON]["shake"]
					if GamemodeManager.GAMEMODE == 3 and unreliableweapon:
						bullet.global_rotation = global_rotation+(sin(randf_range(-64, 64)) )/2.3
					else:
						if WEAPONS[SELECTED_WEAPON]["left_bullets"] == WEAPONS[SELECTED_WEAPON]["bullets"]:
							bullet.global_rotation = global_rotation+(sin(randf_range(-64, 64)))*WEAPONS[SELECTED_WEAPON]["sway"]/1.5
						else:
							bullet.global_rotation = global_rotation+(sin(randf_range(-64, 64)))*WEAPONS[SELECTED_WEAPON]["sway"]					
					get_parent().add_child(bullet)
			else:
				var bullet = P_BULLET.instantiate()
				bullet.global_position = $Marker2D.global_position
				bullet.markerpos = $Marker2D.global_position
				bullet.despawn_dist = WEAPONS[SELECTED_WEAPON]["bulletdespawn_dist"]
				bullet.PIERCETHRU = WEAPONS[SELECTED_WEAPON]["penthrough"]
				bullet.SPEED = WEAPONS[SELECTED_WEAPON]["bullet_speed"]
				bullet.DAMAGE = WEAPONS[SELECTED_WEAPON]["damage"]
				shaketimer = shakedelay
				weaponshakeamount = WEAPONS[SELECTED_WEAPON]["shake"]
				bullet.shotgunbullet = false
				if GamemodeManager.GAMEMODE == 3 and unreliableweapon:
					bullet.global_rotation = global_rotation+(sin(randf_range(-64, 64)) )/2.3
				else:
					if WEAPONS[SELECTED_WEAPON]["left_bullets"] == WEAPONS[SELECTED_WEAPON]["bullets"]:
						bullet.global_rotation = global_rotation+(sin(randf_range(-64, 64)))*WEAPONS[SELECTED_WEAPON]["sway"]/1.5
					else:
						bullet.global_rotation = global_rotation+(sin(randf_range(-64, 64)))*WEAPONS[SELECTED_WEAPON]["sway"]	
						
				get_parent().add_child(bullet)
			WEAPONS[SELECTED_WEAPON]["left_bullets"] -= 1
			WEAPONS[SELECTED_WEAPON]["left_bullets"] = max(0, WEAPONS[SELECTED_WEAPON]["left_bullets"])
			if WEAPONS[SELECTED_WEAPON]["layered_shootsounds"]:
				$ShootLayer1.stream = load(str(WEAPONS[SELECTED_WEAPON]["shootlayer_1"] + "_" + str(randi_range(1,2)).pad_zeros(2)) + ".wav")
				$ShootLayer1.pitch_scale = randf_range(0.93, 1.06)
				$ShootLayer2.stream = load(str(WEAPONS[SELECTED_WEAPON]["shootlayer_2"] + "_" + str(randi_range(1,2)).pad_zeros(2)) + ".wav")
				$ShootLayer2.pitch_scale = randf_range(0.93, 1.06)
				$ShootLayer3.stream = load(str(WEAPONS[SELECTED_WEAPON]["shootlayer_3"] + "_" + str(randi_range(1,2)).pad_zeros(2)) + ".wav")
				$ShootLayer3.pitch_scale = randf_range(0.93, 1.06)
				$ShootLayer1.play()
				$ShootLayer2.play()
				$ShootLayer3.play()
			else:
				$ShootSound.pitch_scale = randf_range(0.93, 1.06)
				$ShootSound.stream = load(WEAPONS[SELECTED_WEAPON]["sound"])
				$ShootSound.play()
			DELAY = 0
			#print(DELAY)
	else:
		$EmptySound.play()
		DELAY = 0
		print(DELAY)
		
func throw():
	if WEAPONS[SELECTED_WEAPON]["left_bullets"] != 0:
		if DELAY >= WEAPONS[SELECTED_WEAPON]["delay"]:
			var grenade = P_GRENADE.instantiate()
			var targetdir = $GrenadeTarget.global_position - global_position
			max_range2 = max_range + randi_range(0, 150)
			if targetdir.length() > max_range:
				$GrenadeTarget.global_position = global_position + targetdir.limit_length(max_range2)
			grenade.global_position = $Marker2D.global_position
			grenade.global_rotation = global_rotation + randf_range(0.9, 1.1)
			get_parent().add_child(grenade)
			grenade.target = $GrenadeTarget.global_position
			WEAPONS[SELECTED_WEAPON]["left_bullets"] -= 1
			WEAPONS[SELECTED_WEAPON]["left_bullets"] = max(0, WEAPONS[SELECTED_WEAPON]["left_bullets"])
			#$ShootSound.pitch_scale = randf_range(0.93, 1.06)
			#$ShootSound.play()
			DELAY = 0
			print(DELAY)
	else:
		$EmptySound.play()
		DELAY = 0
		print(DELAY)
	pass
		
func bullets_reload():
	match GamemodeManager.GAMEMODE:
		1:
			if (WEAPONS[SELECTED_WEAPON]["left_bullets"] == 0):
				WEAPONS[SELECTED_WEAPON]["left_bullets"] = WEAPONS[SELECTED_WEAPON]["bullets"]
				DELAY = 0
				$ReloadSound.pitch_scale = randf_range(0.94, 1.05)
				$ReloadSound.play()
		_:
			if WEAPONS[SELECTED_WEAPON]["incremental_reload"]:
				if WEAPONS[SELECTED_WEAPON]["left_bullets"] < WEAPONS[SELECTED_WEAPON]["bullets"] and WEAPONS[SELECTED_WEAPON]["zapas_bullets"] >= 1:
					maybeselectedweapon = SELECTED_WEAPON
					
					if WEAPONS[SELECTED_WEAPON]["incremental_minusroundonreload"] and WEAPONS[SELECTED_WEAPON]["left_bullets"] > 0 and !RELOADING:
						INCREMENT_DELAY = 0-WEAPONS[SELECTED_WEAPON]["increment_delay"]
						WEAPONS[SELECTED_WEAPON]["left_bullets"] -= 1
					elif !RELOADING:
						INCREMENT_DELAY = 0-WEAPONS[SELECTED_WEAPON]["increment_delay"]/2
					else:
						pass
					ogroundamount = WEAPONS[SELECTED_WEAPON]["left_bullets"]
					RELOADING = true
			else:
				if (WEAPONS[SELECTED_WEAPON]["left_bullets"] == 0) and (WEAPONS[SELECTED_WEAPON]["zapas_bullets"] >= WEAPONS[SELECTED_WEAPON]["bullets"]):
					WEAPONS[SELECTED_WEAPON]["left_bullets"] = WEAPONS[SELECTED_WEAPON]["bullets"]
					DELAY = 0
					WEAPONS[SELECTED_WEAPON]["zapas_bullets"] -= WEAPONS[SELECTED_WEAPON]["bullets"]
					WEAPONS[SELECTED_WEAPON]["zapas_bullets"] = max(0, WEAPONS[SELECTED_WEAPON]["zapas_bullets"])
					$ReloadSound.pitch_scale = randf_range(0.94, 1.05)
					$ReloadSound.stream = load(WEAPONS[SELECTED_WEAPON]["reloadsound"])
					$ReloadSound.play()

func get_input():
	var vertical = Input.get_axis("up", "down")
	var horizontal = Input.get_axis("left", "right")
	return Vector2(horizontal, vertical)
			
func weaponhint_show():
	match GamemodeManager.GAMEMODE:
		-1:
			if GamemodeManager.MODGAME["allow_weapons"]:
				if Global.WEAPONHINTS:
					var iconfile = WEAPONS[SELECTED_WEAPON]["icon"]
					var icon = load(iconfile)
					weapon_icon.texture = icon
					weapon_text.modulate.a = 1
					var weapon_name = tr(WEAPONS[SELECTED_WEAPON]["name"])
					var control_name = Global.weap_chng_btn if Global.CONTROLLER_CONNECTED else tr("$mousewheel")
					weapon_text.text = tr("$selectedweapon") % [weapon_name, control_name]

					if HINT_TWEEN and HINT_TWEEN.is_valid():
						HINT_TWEEN.kill()
					HINT_TWEEN = get_tree().create_tween()
					HINT_TWEEN.tween_property(weapon_text, "modulate:a", 0, 4).set_trans(Tween.TRANS_QUART)
					HINT_TWEEN.play()
		1:
			pass
		_:
			if Global.WEAPONHINTS:
				var iconfile = WEAPONS[SELECTED_WEAPON]["icon"]
				var icon = load(iconfile)
				weapon_icon.texture = icon
				weapon_text.modulate.a = 1
				var weapon_name = tr(WEAPONS[SELECTED_WEAPON]["name"])
				var control_name = Global.weap_chng_btn if Global.CONTROLLER_CONNECTED else tr("$mousewheel")
				weapon_text.text = tr("$selectedweapon") % [weapon_name, control_name]
				if HINT_TWEEN and HINT_TWEEN.is_valid():
					HINT_TWEEN.kill()
				HINT_TWEEN = get_tree().create_tween()
				HINT_TWEEN.tween_property(weapon_text, "modulate:a", 0, 4).set_trans(Tween.TRANS_QUART)
				HINT_TWEEN.play()
			else:
				pass
