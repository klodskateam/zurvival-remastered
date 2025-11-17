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



var VINOSLIVOST = 100
@export var MAX_VINOSLIVOST = 100
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
@export var RUN_SPEED = 400
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
	
	match GamemodeManager.GAMEMODE:
		1:
			pass
		_:
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
		$WalkDelay.wait_time = randf_range(0.20,0.24)
		match randi_range(1,4):
			1:
				$GrassStep01.pitch_scale = randf_range(0.96, 1.02)
				$GrassStep01.play()
			2:
				$GrassStep02.pitch_scale = randf_range(0.96, 1.02)
				$GrassStep02.play()
			3:
				$GrassStep03.pitch_scale = randf_range(0.94, 1.05)
				$GrassStep03.play()
			4:
				$GrassStep04.pitch_scale = randf_range(0.94, 1.05)
				$GrassStep04.play()
	elif (Input.is_action_pressed("up") or Input.is_action_pressed("down") or Input.is_action_pressed("left") or Input.is_action_pressed("right")):
		$WalkDelay.wait_time = randf_range(0.24,0.27)
		match randi_range(1,4):
			1:
				$GrassStep01.pitch_scale = randf_range(0.91, 1.06)
				$GrassStep01.play()
			2:
				$GrassStep02.pitch_scale = randf_range(0.91, 1.06)
				$GrassStep02.play()
			3:
				$GrassStep03.pitch_scale = randf_range(0.89, 1.06)
				$GrassStep03.play()
			4:
				$GrassStep04.pitch_scale = randf_range(0.89, 1.02)
				$GrassStep04.play()
		pass
	
