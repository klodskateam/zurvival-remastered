extends CharacterBody2D

@onready var player: CharacterBody2D = $"../player"

const SPEED = 200
var HP = 100
var DAMAGE = 10

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	
	if HP <= 0:
		$".".queue_free()
	
	look_at($"../player".position)
	
	var direction = get_direction_to_player()
	velocity = SPEED * direction
	move_and_slide()
	
	

func get_direction_to_player():
	var player = get_tree().get_first_node_in_group("player") as Node2D
	
	if player != null:
		return (player.global_position - global_position).normalized()
	return Vector2.ZERO

func _on_area_2d_body_entered(body: Node2D) -> void:
	print(body)
	if body.name == "player":
		body.HEALTH -= DAMAGE
	if body.is_in_group("danger_zombie"):
		HP -= body.DAMAGE
		player.SCORE += 1
		body.queue_free()
