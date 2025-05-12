extends RigidBody2D

const SPEED = 1450
const DAMAGE = 100

func _physics_process(delta):
	linear_velocity = Vector2(0, -SPEED).rotated(global_rotation)
	
