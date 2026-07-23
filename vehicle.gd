extends CharacterBody2D

@onready var idle_engine: AudioStreamPlayer2D = $IdleEngine
@onready var medium_engine: AudioStreamPlayer2D = $MediumEngine
@onready var high_engine: AudioStreamPlayer2D = $HighEngine
@onready var TireAudio: AudioStreamPlayer2D = $TiresRolling
@onready var TireSkid: AudioStreamPlayer2D = $TireSkid


@export var driver : Node2D
var driving = false
var direction : Vector2
var throttle = 0
var STEERING_SPEED = 0
var CURRENT_SPEED = 0
var RPM = 0

var VEHICLE =	{
		"driver_position": [-64, -17],
		"driver_hidden": false,	
		"engine_power": 4,
		"vehicle_maximumspeed": 800,
		"vehicle_maximumbackspeed": 210,
		"vehicle_steermultiplier": 5,
		"vehicle_maxsteer": 80, 
		"vehicle_steerdamp": 3.7,
		"vehicle_tiregrip": 0.9,
		"vehicle_tiredriftbrake": 4.5,
		"vehicle_tireslip": 2.4,
	}

func _physics_process(delta: float) -> void:
	if driver != null and direction:
		#print("auf")
		throttle += VEHICLE["engine_power"] * direction.y * delta
		STEERING_SPEED += clampf(direction.x * abs(clampf(abs(CURRENT_SPEED)/VEHICLE["vehicle_maximumspeed"], 0, 1.0)) * delta * VEHICLE["vehicle_steermultiplier"], -VEHICLE["vehicle_maxsteer"], VEHICLE["vehicle_maxsteer"])
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
		direction = driver.get_input()
		CURRENT_SPEED += throttle * 100 * delta
		if abs(throttle) < 0.65:
			CURRENT_SPEED = lerp(CURRENT_SPEED, 0.0, 0.001)
		if abs(CURRENT_SPEED) <= 10 and !direction:
			CURRENT_SPEED = 0
		throttle = clampf(throttle, -1, 2)	
		CURRENT_SPEED = clampf(CURRENT_SPEED, -VEHICLE["vehicle_maximumspeed"], VEHICLE["vehicle_maximumbackspeed"])
		if abs(velocity.length()) >= 25 and STEERING_SPEED >= 0.05:
			CURRENT_SPEED = lerpf(CURRENT_SPEED, 0, (1-abs(velocity.normalized().dot(Vector2.DOWN.rotated(rotation))))*VEHICLE["vehicle_tiredriftbrake"]*delta)
			STEERING_SPEED += sign(STEERING_SPEED)*pow((1-abs(velocity.normalized().dot(Vector2.DOWN.rotated(rotation)))), 2)*(VEHICLE["vehicle_tireslip"]*10)*delta
		STEERING_SPEED = lerpf(STEERING_SPEED, 0, VEHICLE["vehicle_steerdamp"]*delta)
		if velocity.length() > 0:
			RPM = clampf((abs(CURRENT_SPEED)/VEHICLE["vehicle_maximumspeed"])*(abs(throttle)), 0, 1)
		else:
			RPM = clampf((abs(CURRENT_SPEED)/VEHICLE["vehicle_maximumbackspeed"]/2)*(abs(throttle)/2), 0, 1)
		
		idle_engine.volume_linear = clampf(absf(RPM)*2, 0, 1)
		medium_engine.volume_linear = clampf(absf(RPM - 0.5)*2, 0, 1)
		high_engine.volume_linear = clampf(absf(RPM - 0.1)*2, 0, 1)
		
		idle_engine.pitch_scale = clampf(lerpf(0.9, 1.4, clampf(RPM*2, 0, 1)), 0.05, 1.5)
		medium_engine.pitch_scale = clampf(lerpf(0.5, 1.5, RPM), 0.05, 1.5)
		high_engine.pitch_scale = clampf(lerpf(0.7, 1.2, clampf((RPM-0.5)*2, 0, 1)), 0.05, 1.5)
		
		TireAudio.volume_linear = clampf((abs(CURRENT_SPEED)/VEHICLE["vehicle_maximumspeed"])*5, 0.05, 5)
		TireAudio.pitch_scale = clampf(lerpf(0.9, 5.8, abs(CURRENT_SPEED)/VEHICLE["vehicle_maximumspeed"]), 0.05, 1.5)
		
		TireSkid.volume_linear = clampf((abs(CURRENT_SPEED*2)/VEHICLE["vehicle_maximumspeed"]) * (1-abs(velocity.normalized().dot(Vector2.DOWN.rotated(rotation)))), 0.05, 4)
		TireSkid.pitch_scale = clampf(lerpf(0.9, 2.8, abs(CURRENT_SPEED/4)/VEHICLE["vehicle_maximumspeed"]), 0.05, 1.5)
		
		rotation += STEERING_SPEED * delta
		velocity = velocity.lerp(Vector2.DOWN.rotated(rotation) * CURRENT_SPEED, VEHICLE["vehicle_tiregrip"]*delta)
	move_and_slide()
