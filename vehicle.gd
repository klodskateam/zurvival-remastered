extends CharacterBody2D

@export var driver : Node2D
var driving = false
var direction : Vector2
var steer_direction

var VEHICLE = [
	{
		"driver_position": [-64, -17],
		"driver_hidden": false,
	}
]

func _physics_process(delta: float) -> void:
	
	if driver != null and !driving:
		await get_tree().process_frame
		driver.reparent(self)
		driver.position = Vector2(VEHICLE[0]["driver_position"][0], VEHICLE[0]["driver_position"][1])
		driver.driving = true
		driving = true
	pass
	if driver != null and driving:
		velocity = transform.x * 500
		pass
	#velocity += Vector2(0, -2)*rotation
	move_and_slide()
