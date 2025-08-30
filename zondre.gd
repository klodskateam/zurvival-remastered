extends CharacterBody2D

# ЗОНДРЕ НАХ 😨😨😨😨😨😨😨😨😨😨😨😨😨😨😨😨😨😨😨😨😨😨😨😨😨😨😨😨😨😨😨😨😨😨😨😨😨😨😨😨😨😨
# ЗОНДРЕ НАХ 😨😨😨😨😨😨😨😨😨😨😨😨😨😨😨😨😨😨😨😨😨😨😨😨😨😨😨😨😨😨😨😨😨😨😨😨😨😨😨😨😨😨
# ЗОНДРЕ НАХ 😨😨😨😨😨😨😨😨😨😨😨😨😨😨😨😨😨😨😨😨😨😨😨😨😨😨😨😨😨😨😨😨😨😨😨😨😨😨😨😨😨😨
# ЗОНДРЕ НАХ 😨😨😨😨😨😨😨😨😨😨😨😨😨😨😨😨😨😨😨😨😨😨😨😨😨😨😨😨😨😨😨😨😨😨😨😨😨😨😨😨😨😨
# ЗОНДРЕ НАХ 😨😨😨😨😨😨😨😨😨😨😨😨😨😨😨😨😨😨😨😨😨😨😨😨😨😨😨😨😨😨😨😨😨😨😨😨😨😨😨😨😨😨
# ЗОНДРЕ НАХ 😨😨😨😨😨😨😨😨😨😨😨😨😨😨😨😨😨😨😨😨😨😨😨😨😨😨😨😨😨😨😨😨😨😨😨😨😨😨😨😨😨😨
# ЗОНДРЕ НАХ 😨😨😨😨😨😨😨😨😨😨😨😨😨😨😨😨😨😨😨😨😨😨😨😨😨😨😨😨😨😨😨😨😨😨😨😨😨😨😨😨😨😨
# ЗОНДРЕ НАХ 😨😨😨😨😨😨😨😨😨😨😨😨😨😨😨😨😨😨😨😨😨😨😨😨😨😨😨😨😨😨😨😨😨😨😨😨😨😨😨😨😨😨
# ЗОНДРЕ НАХ 😨😨😨😨😨😨😨😨😨😨😨😨😨😨😨😨😨😨😨😨😨😨😨😨😨😨😨😨😨😨😨😨😨😨😨😨😨😨😨😨😨😨
# ЗОНДРЕ НАХ 😨😨😨😨😨😨😨😨😨😨😨😨😨😨😨😨😨😨😨😨😨😨😨😨😨😨😨😨😨😨😨😨😨😨😨😨😨😨😨😨😨😨

@onready var player: CharacterBody2D = $"../player"
@onready var navagent: NavigationAgent2D = $NavigationAgent2D
@onready var timer: Timer = $Timer

const SPEED = 217
var HP = 100
var DAMAGE = 10

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _physics_process(delta: float) -> void:
	match GamemodeManager.GAMEMODE:
		1:
			DAMAGE = 100
		_:
			DAMAGE = 10
	
	if HP <= 0:
		$".".queue_free()
	
	look_at($"../player".position)
	nav(delta)
	
func nav(delta: float) -> void:
	if navagent.is_navigation_finished():
		return
	var nextpath: Vector2 = navagent.get_next_path_position()
	var newvelocity: Vector2 = (global_position.direction_to(nextpath) * SPEED)
	position += newvelocity * delta
	if player != null:
		navagent.target_position = player.global_position
	pass

func _on_timer_timeout() -> void:
	navagent.target_position = player.global_position

#func get_direction_to_player():
#	var player = get_tree().get_first_node_in_group("player") as Node2D
#	
#	if player != null:
#		return (player.global_position - global_position).normalized()
#	return Vector2.ZERO

func _on_area_2d_body_entered(body: Node2D) -> void:
	print(body)
	if body.name == "player":
		body.HEALTH -= DAMAGE
	if body.is_in_group("danger_zombie"):
		HP -= body.DAMAGE
		player.SCORE += 1
		body.queue_free()
