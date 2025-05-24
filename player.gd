extends CharacterBody2D
class_name Player

@onready var score: Label = $"../UI/Score"

@onready var kaktameto: Label = $"../UI/SpeedBar/Speed"
@onready var kaktameto_bar: ProgressBar = $"../UI/SpeedBar"

@onready var bullets: Label = $"../UI/BulletsBar/Bullets"
@onready var bullets_bar: ProgressBar = $"../UI/BulletsBar"

@onready var health: Label = $"../UI/HealthBar/Health"
@onready var health_bar: ProgressBar = $"../UI/HealthBar"


var VINOSLIVOST = 100
@export var MAX_VINOSLIVOST = 100
var SPEED = 325
var BULLETS = 12
var ZAPAS_BULLETS = 48
var DELAY = 0
var HEALTH = 100
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
	
	kaktameto.text = tr("$stamina") + ": " + str(round(int(VINOSLIVOST))) + "/" + str(MAX_VINOSLIVOST)
	kaktameto_bar.max_value = MAX_VINOSLIVOST
	kaktameto_bar.value = VINOSLIVOST

	bullets.text = tr("$bullets") + ": " + str(BULLETS) + "/" + str(ZAPAS_BULLETS)
	bullets_bar.max_value = MAX_BULLETS
	bullets_bar.value = BULLETS
	
	health.text = tr("$health") + ": " + str(HEALTH) + "/" + str(MAX_HEALTH)
	health_bar.max_value = MAX_HEALTH
	health_bar.value = HEALTH
	
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
#			$Camera2D.zoom = Vector2(1, 1)
			RUNLOCK = 1
	else:
		SPEED = REGULAR_SPEED
		if (VINOSLIVOST <= MAX_VINOSLIVOST) and (SPEED != RUN_SPEED):
			VINOSLIVOST += 6.5 * delta
			fov_down()
#			$Camera2D.zoom = Vector2(1, 1)
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
	if (HEALTH <= 0) and ($Person != null):
		$"../PauseManager".PAUSE = true
		$"../PauseManager".PAUSELOCK = true
		$Person.queue_free()
		$"../GameOver".show()
		$"../GameOver".set_scores()
	if (HEALTH <= 20):
		$"../UI/VignetteRed".lowhealth = true
	else:
		$"../UI/VignetteRed".lowhealth = false		
		
		
	
func _input(event):
	
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
	if (BULLETS == 0) and (ZAPAS_BULLETS >= 12):
		BULLETS = MAX_BULLETS
		DELAY = 0
		ZAPAS_BULLETS -= 12
		$ReloadSound.pitch_scale = randf_range(0.94, 1.05)
		$ReloadSound.play()
