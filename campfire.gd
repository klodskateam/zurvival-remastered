extends Area2D

@onready var zesty_bar = $ProgressBar
@onready var burnlight = $"../CampfireLight"
var ENERGY = 200

func _on_timer_timeout() -> void:
	ENERGY -= 5
	
func _process(delta: float) -> void:
	zesty_bar.value = ENERGY
	if ENERGY <= 0 and GamemodeManager.GAMEMODE == 2:
		zesty_bar.visible = false
		burnlight.visible = false
		$CampfireBurning.texture = load("res://Resources/campfire_notburning.png")
	if GamemodeManager.GAMEMODE != 2:
		zesty_bar.visible = false

func _on_body_entered(body: Node2D):
	if body.name == "player" and body.INVENTORY_FILLED > 0 and ENERGY > 0: 
		ENERGY += body.INVENTORY_FILLED
		body.INVENTORY_FILLED = 0

	
