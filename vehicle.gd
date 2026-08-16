extends CharacterBody2D

@export var P_BULLET = preload("res://bullet.tscn")
@onready var idle_engine: AudioStreamPlayer2D = $IdleEngine
@onready var medium_engine: AudioStreamPlayer2D = $MediumEngine
@onready var high_engine: AudioStreamPlayer2D = $HighEngine
@onready var TireAudio: AudioStreamPlayer2D = $TiresRolling
@onready var TireSkid: AudioStreamPlayer2D = $TireSkid
@onready var MG: Sprite2D = $MG
@onready var MGMarker: Marker2D = $MG/Marker2D


@export var driver : Node2D
var driving = false
var direction : Vector2
var throttle = 0
var STEERING_SPEED = 0
var CURRENT_SPEED = 0
var RPM = 0

var DELAY = 0
var RELOADING = false


var VEHICLE =	{
		"driver_position": [-64, -17],
		"driver_hidden": false,	
		"engine_power": 1.4,
		"vehicle_maximumspeed": 800,
		"vehicle_maximumbackspeed": 210,
		"vehicle_steermultiplier": 5,
		"vehicle_maxsteer": 8, 
		"vehicle_steerdamp": 3.7,
		"vehicle_tiregrip": 0.7,
		"vehicle_tiredriftbrake": 2.6,
		"vehicle_tireslip": 1.2,
		
		"weapon_available": true,
		"weapon_turnmultiplier": 8,
		
		"weapon": {
			"name": "TEST_MG108",
			"id": 8,
			"delay": 0.52,
			"damage": 100,
			"bullet_speed": 1520,
			"automatic": true,
			"bullets": 50,
			"left_bullets": 50,
			"zapas_bullets": 100,
			"type": "gun",
			"sway": 0.02,
			"penthrough": false,
			"bulletdespawn_dist": 2000,
			"sound": "res://Sound/mg108.wav",
			"reloadsound": "res://Sound/mg108-reload.wav",
			"layered_shootsounds": true,
			"shootlayer_1": "res://Sound/mg108_main",
			"shootlayer_2": "res://Sound/mg108_tail",
			"shootlayer_3": "res://Sound/mg108_misc",
		}
	
	}

func _input(event: InputEvent) -> void:
	if event.is_action_pressed("shoot") and VEHICLE["weapon"]["type"] != "grenade" and driving:
		if (OS.get_name() != "Android"):
			shoot()
	if event.is_action_pressed("reload") and driving:
		bullets_reload()

func _process(delta: float) -> void:
	if Input.is_action_pressed("shoot") and driving:
		ratata()

func _physics_process(delta: float) -> void:
	if driver != null and direction:
		#print("auf")
		throttle += VEHICLE["engine_power"] * direction.y * delta
		STEERING_SPEED += clampf(direction.x * abs(clampf(pow(abs(CURRENT_SPEED)/VEHICLE["vehicle_maximumspeed"], 1.4), 0, 1.0)) * delta * VEHICLE["vehicle_steermultiplier"], -VEHICLE["vehicle_maxsteer"], VEHICLE["vehicle_maxsteer"])
	elif driver != null:
		if abs(STEERING_SPEED) >= 30:
			throttle = lerpf(throttle, 0, (delta/2) * (1-(abs(CURRENT_SPEED)/VEHICLE["vehicle_maximumspeed"])+0.05))
		else:
			throttle = lerpf(throttle, 0, 2 * delta * (1-(abs(CURRENT_SPEED)/VEHICLE["vehicle_maximumspeed"])+0.1))
		
	#print("THR: " + str(throttle))
	
	if driver != null and !driving:
		await get_tree().process_frame
		driver.reparent(self)
		driver.position = Vector2(VEHICLE["driver_position"][0], VEHICLE["driver_position"][1])
		if VEHICLE["driver_hidden"]:
			driver.visible = false
		driver.driving = true
		driver.driving_ui()
		driving = true
		
	if driver != null and driving:
		if VEHICLE["weapon_available"]:
			MG.rotation = lerp_angle(MG.rotation, get_angle_to(get_global_mouse_position())+PI/2, delta*VEHICLE["weapon_turnmultiplier"])
		else:
			MG.visible = false
		direction = driver.get_input()
		CURRENT_SPEED += throttle * 100 * delta
		if abs(throttle) < 0.65:
			CURRENT_SPEED = lerp(CURRENT_SPEED, 0.0, 0.001)
		if abs(CURRENT_SPEED) <= 10 and !direction:
			CURRENT_SPEED = 0
		throttle = clampf(throttle, -1, 2)	
		CURRENT_SPEED = clampf(CURRENT_SPEED, -VEHICLE["vehicle_maximumspeed"], VEHICLE["vehicle_maximumbackspeed"])
		if abs(velocity.length()) >= 25 and abs(STEERING_SPEED) >= 0.05:
			CURRENT_SPEED = lerpf(CURRENT_SPEED, 0, (1-abs(velocity.normalized().dot(Vector2.DOWN.rotated(rotation))))*VEHICLE["vehicle_tiredriftbrake"]*(delta/1.5))
			STEERING_SPEED += sign(STEERING_SPEED)*pow((1-abs(velocity.normalized().dot(Vector2.DOWN.rotated(rotation)))), 2)*(VEHICLE["vehicle_tireslip"]*10)*delta
		STEERING_SPEED = lerpf(STEERING_SPEED, 0, VEHICLE["vehicle_steerdamp"]*delta)
		if velocity.length() > 0:
			RPM = lerpf(RPM, clampf((abs(CURRENT_SPEED)/VEHICLE["vehicle_maximumspeed"])*(abs(throttle)), 0, 1), delta/2)
		else:
			RPM = lerpf(RPM,clampf((abs(CURRENT_SPEED)/VEHICLE["vehicle_maximumbackspeed"]/2)*(abs(throttle)/2), 0, 1), delta/2)
		
		rotation += STEERING_SPEED * delta
		velocity = velocity.lerp(Vector2.DOWN.rotated(rotation) * CURRENT_SPEED, VEHICLE["vehicle_tiregrip"]*delta)
		
	idle_engine.volume_linear = clampf(1- pow(absf(RPM), 2), 0, 1)
	medium_engine.volume_linear = clampf(1- pow(absf(RPM - 0.5), 2), 0, 1)
	high_engine.volume_linear = clampf(absf(RPM - 0.1)*2, 0, 1)
		
	idle_engine.pitch_scale = clampf(lerpf(0.9, 1.4, clampf(RPM*2, 0, 1)), 0.05, 1.5)
	medium_engine.pitch_scale = clampf(lerpf(0.5, 1.5, RPM), 0.05, 1.5)
	high_engine.pitch_scale = clampf(lerpf(0.7, 1.2, clampf((RPM-0.5)*2, 0, 1)), 0.05, 1.5)
	
	TireAudio.volume_linear = clampf((abs(CURRENT_SPEED)/VEHICLE["vehicle_maximumspeed"])*5, 0.05, 5)
	TireAudio.pitch_scale = clampf(lerpf(0.2, 3.8, abs(CURRENT_SPEED/1.5)/VEHICLE["vehicle_maximumspeed"]), 0.05, 5)
	
	TireSkid.volume_linear = clampf((abs(CURRENT_SPEED*2)/VEHICLE["vehicle_maximumspeed"]) * (1-abs(velocity.normalized().dot(Vector2.DOWN.rotated(rotation)))), 0.01, 4)
	TireSkid.pitch_scale = clampf(lerpf(0.7, 10.8, abs(CURRENT_SPEED/4)/VEHICLE["vehicle_maximumspeed"]), 0.05, 20)
	
	
	if DELAY <= VEHICLE["weapon"]["delay"]:
		DELAY += 5.3 * delta
	
	move_and_slide()
	
func ratata():
	if !VEHICLE["weapon"]["automatic"] or VEHICLE["weapon"]["type"] == "grenade":
		return
	if VEHICLE["weapon"]["left_bullets"] > 0 and DELAY >= VEHICLE["weapon"]["delay"]:
		shoot()
		
func shoot():
	if VEHICLE["weapon"]["left_bullets"] != 0:
		if DELAY >= VEHICLE["weapon"]["delay"]:
			# bullet.add_constant_force(get_global_mouse_position() - bullet.global_position)
			if VEHICLE["weapon"]["type"] == "shotgun":
				#$Camera2D/AnimationPlayer.stop()
				#$Camera2D/AnimationPlayer.play("shotgun_recoil")	
				for i in 9:
					var bullet = P_BULLET.instantiate()
					bullet.shotgunbullet = true
					bullet.global_position = MGMarker.global_position
					bullet.markerpos = MGMarker.global_position
					bullet.despawn_dist = VEHICLE["weapon"]["bulletdespawn_dist"]
					bullet.PIERCETHRU = VEHICLE["weapon"]["penthrough"]
					bullet.DAMAGE = VEHICLE["weapon"]["damage"]
					bullet.SPEED = VEHICLE["weapon"]["bullet_speed"]
					if VEHICLE["weapon"]["left_bullets"] == VEHICLE["weapon"]["bullets"]:
						bullet.global_rotation = global_rotation+(sin(randf_range(-64, 64)))*VEHICLE["weapon"]["sway"]/1.5
					else:
						bullet.global_rotation = global_rotation+(sin(randf_range(-64, 64)))*VEHICLE["weapon"]["sway"]					
					get_parent().add_child(bullet)
			else:
				var bullet = P_BULLET.instantiate()
				bullet.global_position = MGMarker.global_position
				bullet.markerpos = MGMarker.global_position
				bullet.despawn_dist = VEHICLE["weapon"]["bulletdespawn_dist"]
				bullet.PIERCETHRU = VEHICLE["weapon"]["penthrough"]
				bullet.SPEED = VEHICLE["weapon"]["bullet_speed"]
				bullet.DAMAGE = VEHICLE["weapon"]["damage"]
				if VEHICLE["weapon"]["left_bullets"] == VEHICLE["weapon"]["bullets"]:
					bullet.global_rotation = MG.global_rotation+(sin(randf_range(-64, 64)))*VEHICLE["weapon"]["sway"]/1.5
				else:
					bullet.global_rotation = MG.global_rotation+(sin(randf_range(-64, 64)))*VEHICLE["weapon"]["sway"]				
				get_parent().add_child(bullet)
			VEHICLE["weapon"]["left_bullets"] -= 1
			VEHICLE["weapon"]["left_bullets"] = max(0, VEHICLE["weapon"]["left_bullets"])
			if VEHICLE["weapon"]["layered_shootsounds"]:
				$ShootLayer1.stream = load(str(VEHICLE["weapon"]["shootlayer_1"] + "_" + str(randi_range(1,2)).pad_zeros(2)) + ".wav")
				$ShootLayer1.pitch_scale = randf_range(0.93, 1.06)
				$ShootLayer2.stream = load(str(VEHICLE["weapon"]["shootlayer_2"] + "_" + str(randi_range(1,2)).pad_zeros(2)) + ".wav")
				$ShootLayer2.pitch_scale = randf_range(0.93, 1.06)
				$ShootLayer3.stream = load(str(VEHICLE["weapon"]["shootlayer_3"] + "_" + str(randi_range(1,2)).pad_zeros(2)) + ".wav")
				$ShootLayer3.pitch_scale = randf_range(0.93, 1.06)
				$ShootLayer1.play()
				$ShootLayer2.play()
				$ShootLayer3.play()
			else:
				$ShootSound.pitch_scale = randf_range(0.93, 1.06)
				$ShootSound.stream = load(VEHICLE["weapon"]["sound"])
				$ShootSound.play()
			DELAY = 0
			#print(DELAY)
	else:
		$EmptySound.play()
		DELAY = 0
		print(DELAY)
		
func bullets_reload():
	if (VEHICLE["weapon"]["left_bullets"] == 0) and (VEHICLE["weapon"]["zapas_bullets"] >= VEHICLE["weapon"]["bullets"]):
		VEHICLE["weapon"]["left_bullets"] = VEHICLE["weapon"]["bullets"]
		DELAY = 0
		VEHICLE["weapon"]["zapas_bullets"] -= VEHICLE["weapon"]["bullets"]
		VEHICLE["weapon"]["zapas_bullets"] = max(0, VEHICLE["weapon"]["zapas_bullets"])
		$ReloadSound.pitch_scale = randf_range(0.94, 1.05)
		$ReloadSound.stream = load(VEHICLE["weapon"]["reloadsound"])
		$ReloadSound.play()
