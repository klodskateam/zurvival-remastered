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

@onready var vignette_red = $"../UI/VignetteRed"


const GRASS_STEP_01 = preload("res://Sound/grass_step_01.wav")
const GRASS_STEP_02 = preload("res://Sound/grass_step_02.wav")
const GRASS_STEP_03 = preload("res://Sound/grass_step_03.wav")
const GRASS_STEP_04 = preload("res://Sound/grass_step_04.wav")

const PICKUP_01 = preload("res://Sound/pickup_01.wav")
const PICKUP_02 = preload("res://Sound/pickup_02.wav")
const PICKUP_MEDKIT_01 = preload("res://Sound/pickup_medkit_01.wav")
const PICKUP_MEDKIT_02 = preload("res://Sound/pickup_medkit_02.wav")



var VINOSLIVOST = 100
@export var MAX_VINOSLIVOST = 100
var pickedup : bool = false
var pickedup_medkit : bool = false
var pickedup_plank : bool = false
var SPEED = 325
var BULLETS = 12
var ZAPAS_BULLETS = 48
var DELAY = 0
var HEALTH = 100
var COLDNESS = 0
var INVENTORY_FILLED = 0
@export var MAX_INVENTORY_FILLED = 100
@export var MAX_COLDNESS = 100
@export var MAX_HEALTH = 100
@export var MAX_BULLETS = 12
var SCORE = 0
var RUNLOCK = 0
@export var ded: bool = false

@export var REGULAR_SPEED = 300
@export var RUN_SPEED = 410
@export var P_BULLET = preload("res://bullet.tscn")

func _physics_process(delta: float):
	#TranslationServer.set_locale("be")
	
	if Input.is_action_pressed("left"):
		position.x -= SPEED * delta
	if Input.is_action_pressed("right"):
		position.x += SPEED * delta
	if Input.is_action_pressed("up"):
		position.y -= SPEED * delta
	if Input.is_action_pressed("down"):
		position.y += SPEED * delta
		
	score.text = str(SCORE)
	
	if kaktameto_bar:
		kaktameto.text = tr("$stamina") + ": " + str(round(int(VINOSLIVOST))) + "/" + str(MAX_VINOSLIVOST)
		kaktameto_bar.max_value = MAX_VINOSLIVOST
		kaktameto_bar.value = VINOSLIVOST
	else:
		pass
	match GamemodeManager.GAMEMODE:
		1:
			bullets.text = tr("$bullets") + ": " + str(BULLETS)
			bullets_bar.max_value = MAX_BULLETS
			bullets_bar.value = BULLETS
		_:	
			bullets.text = tr("$bullets") + ": " + str(BULLETS) + "/" + str(ZAPAS_BULLETS)
			bullets_bar.max_value = MAX_BULLETS
			bullets_bar.value = BULLETS
	
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
	
	
	if Input.is_action_pressed("run") and (Input.is_action_pressed("up") or Input.is_action_pressed("down") or Input.is_action_pressed("left") or Input.is_action_pressed("right")) and RUNLOCK != 1:
		print(SPEED)
		print(VINOSLIVOST)
		if (VINOSLIVOST >= 40):
			RUN_SPEED = 410 
			fov_up()
		#	$Camera2D.zoom = Vector2(0.98, 0.98)
		else:
			RUN_SPEED = 345
			fov_half_up()
		#	$Camera2D.zoom = Vector2(0.987, 0.987)
		if (VINOSLIVOST >= 0):
			SPEED = RUN_SPEED
			VINOSLIVOST -= 19.5 * delta
		else:
			SPEED = REGULAR_SPEED
			fov_down()
#					$Camera2D.zoom = Vector2(1, 1)
			RUNLOCK = 1
	else:
		SPEED = REGULAR_SPEED
		if (VINOSLIVOST <= MAX_VINOSLIVOST) and (SPEED != RUN_SPEED):
			VINOSLIVOST += 6.5 * delta
			fov_down()
#					$Camera2D.zoom = Vector2(1, 1)
	if (VINOSLIVOST <= 35) and !Input.is_action_pressed("run"):
		RUNLOCK = 1
	if (VINOSLIVOST >= 35):
		RUNLOCK = 0
		
	match GamemodeManager.GAMEMODE:
		1:
			pass
		2:
			if Input.is_action_pressed("run") and (Input.is_action_pressed("up") or Input.is_action_pressed("down") or Input.is_action_pressed("left") or Input.is_action_pressed("right")) and RUNLOCK != 1:
				SPEED = clamp(RUN_SPEED - (INVENTORY_FILLED*4), 150, 400)
			else:
				SPEED = clamp(REGULAR_SPEED - (INVENTORY_FILLED*3.5), 150, 400)
		_:
			pass
	
	
		
	if (OS.get_name() != "Android"):
		look_at(get_global_mouse_position())
		rotate(PI / 2)
	if DELAY <= 1:
		DELAY += 5.3 * delta
		print(DELAY)

func fov_up():
	var tween = $Camera2D.create_tween()
	tween.tween_property($Camera2D, "zoom", Vector2(0.907, 0.907), 0.8)
func fov_half_up():
	var tween = $Camera2D.create_tween()
	tween.tween_property($Camera2D, "zoom", Vector2(0.954, 0.954), 2)
func fov_down():
	var tween = $Camera2D.create_tween()
	tween.tween_property($Camera2D, "zoom", Vector2(1, 1), 1.4)
		
	
func _process(delta: float):
	if (OS.get_name() == "Android"):
		if $"../../GlobalInterface/joysticks/VirtualJoystick2" and $"../../GlobalInterface/joysticks/VirtualJoystick2".is_pressed:
			rotation = $"../../GlobalInterface/joysticks/VirtualJoystick2".output.angle()
			rotate(PI / 2)
	if (HEALTH <= 0) and ($Person != null) or (GamemodeManager.GAMEMODE == 2 and COLDNESS >= 100):
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

	
func _input(event):
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
	
	if event.is_action_pressed("shoot"):
		if (OS.get_name() != "Android"):
			shoot()
		
	
	if event.is_action_pressed("reload"):
		bullets_reload()
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
		$Pickup01.pitch_scale = randf_range(0.89, 0.98)
		match randi_range(1,2):
			1:
				$Pickup01.stream = PICKUP_01
			2:
				$Pickup01.stream = PICKUP_02
		$Pickup01.play()

	
func shoot():
	if BULLETS != 0:
		if DELAY >= 1:
			var bullet = P_BULLET.instantiate()
			bullet.global_position = $Marker2D.global_position
			bullet.global_rotation = global_rotation
			# bullet.add_constant_force(get_global_mouse_position() - bullet.global_position)
			get_parent().add_child(bullet)
			BULLETS -= 1
			$ShootSound.pitch_scale = randf_range(0.93, 1.06)
			$ShootSound.play()
			DELAY = 0
			print(DELAY)
	else:
		$EmptySound.play()
		DELAY = 0
		print(DELAY)
		
func bullets_reload():
	match GamemodeManager.GAMEMODE:
		1:
			if (BULLETS == 0):
				BULLETS = MAX_BULLETS
				DELAY = 0
				$ReloadSound.pitch_scale = randf_range(0.94, 1.05)
				$ReloadSound.play()
		_:
			if (BULLETS == 0) and (ZAPAS_BULLETS >= 12):
				BULLETS = MAX_BULLETS
				DELAY = 0
				ZAPAS_BULLETS -= 12
				$ReloadSound.pitch_scale = randf_range(0.94, 1.05)
				$ReloadSound.play()

func _on_walkdelay_timeout() -> void:
	if Input.is_action_pressed("run") and (Input.is_action_pressed("up") or Input.is_action_pressed("down") or Input.is_action_pressed("left") or Input.is_action_pressed("right")) and RUNLOCK != 1:
		$WalkDelay.wait_time = randf_range((clamp(0.20 + (INVENTORY_FILLED*0.0025), 0.10, 0.60)),(clamp(0.24 + (INVENTORY_FILLED*0.0035), 0.10, 0.60)))
		$GrassStep01.pitch_scale = randf_range(0.96, 1.02)
		match randi_range(1,4):
			1:
				$GrassStep01.stream = GRASS_STEP_01
			2:
				$GrassStep01.stream = GRASS_STEP_02
			3:
				$GrassStep01.stream = GRASS_STEP_03
			4:
				$GrassStep01.stream = GRASS_STEP_04
		$GrassStep01.play()
	elif (Input.is_action_pressed("up") or Input.is_action_pressed("down") or Input.is_action_pressed("left") or Input.is_action_pressed("right")):
		$WalkDelay.wait_time = randf_range((clamp(0.24 + (INVENTORY_FILLED*0.0045), 0.10, 0.60)),(clamp(0.27 + (INVENTORY_FILLED*0.0050), 0.10, 0.60)))
		$GrassStep01.pitch_scale = randf_range(0.91, 1.06)
		match randi_range(1,4):
			1:
				$GrassStep01.stream = GRASS_STEP_01
			2:
				$GrassStep01.stream = GRASS_STEP_02
			3:
				$GrassStep01.stream = GRASS_STEP_03
			4:
				$GrassStep01.stream = GRASS_STEP_04
		$GrassStep01.play()
