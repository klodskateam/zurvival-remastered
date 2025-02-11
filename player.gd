extends CharacterBody2D

@onready var score: Label = $"../UI/Score"

@onready var kaktameto: Label = $"../UI/SpeedBar/Speed"
@onready var kaktameto_bar: ProgressBar = $"../UI/SpeedBar"

@onready var bullets: Label = $"../UI/BulletsBar/Bullets"
@onready var bullets_bar: ProgressBar = $"../UI/BulletsBar"

@onready var health: Label = $"../UI/HealthBar/Health"
@onready var health_bar: ProgressBar = $"../UI/HealthBar"


var VINOSLIVOST = 100
var MAX_VINOSLIVOST = 100
var SPEED = 300
var BULLETS = 12
var ZAPAS_BULLETS = 48
var DELAY = 0
var HEALTH = 100
var MAX_HEALTH = 100
var MAX_BULLETS = 12
var SCORE = 0

const REGULAR_SPEED = 300
const RUN_SPEED = 400
const P_BULLET = preload("res://bullet.tscn")

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
	
	kaktameto.text = tr("$stamina") + ": " + str(round(VINOSLIVOST)) + "/" + str(MAX_VINOSLIVOST)
	kaktameto_bar.max_value = MAX_VINOSLIVOST
	kaktameto_bar.value = VINOSLIVOST

	bullets.text = tr("$bullets") + ": " + str(BULLETS) + "/" + str(ZAPAS_BULLETS)
	bullets_bar.max_value = MAX_BULLETS
	bullets_bar.value = BULLETS
	
	health.text = tr("$health") + ": " + str(HEALTH) + "/" + str(MAX_HEALTH)
	health_bar.max_value = MAX_HEALTH
	health_bar.value = HEALTH
	
	if Input.is_action_pressed("run"):
		print(SPEED)
		print(VINOSLIVOST)
		if (VINOSLIVOST >= 0):
			SPEED = RUN_SPEED
			$Camera2D.zoom = Vector2(0.99, 0.99)
			VINOSLIVOST -= 0.1
		else:
			SPEED = REGULAR_SPEED
			$Camera2D.zoom = Vector2(1, 1)
	else:
		SPEED = REGULAR_SPEED
		if (VINOSLIVOST <= MAX_VINOSLIVOST) and (SPEED != RUN_SPEED):
			VINOSLIVOST += 0.1
			$Camera2D.zoom = Vector2(1, 1)
	
	look_at(get_global_mouse_position())
	rotate(PI / 2)
	if DELAY <= 1:
		DELAY += 0.075
		print(DELAY)
	
	
func _input(event):
	
	if event.is_action_pressed("shoot"):
		if BULLETS != 0:
			if DELAY >= 1:
				var bullet = P_BULLET.instantiate()
				bullet.global_position = $Marker2D.global_position
				bullet.global_rotation = global_rotation
				# bullet.add_constant_force(get_global_mouse_position() - bullet.global_position)
				get_parent().add_child(bullet)
				BULLETS -= 1
				$ShootSound.pitch_scale = randf_range(0.9, 1.1)
				$ShootSound.play()
				DELAY = 0
				print(DELAY)
		else:
			$EmptySound.play()
			DELAY = 0
			print(DELAY)
	
	if event.is_action_pressed("reload"):
		if (BULLETS == 0) and (ZAPAS_BULLETS >= 12):
			BULLETS = MAX_BULLETS
			ZAPAS_BULLETS -= 12
			$ReloadSound.pitch_scale = randf_range(0.9, 1.1)
			$ReloadSound.play()
		
