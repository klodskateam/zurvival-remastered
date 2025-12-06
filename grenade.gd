extends RigidBody2D
@onready var damage_area: Area2D = $DamageArea
@onready var shake_area: Area2D = $ShakeArea
@onready var player: CharacterBody2D = $"../player"
var target : Vector2 = Vector2.ZERO
var SPEED = 335.0
var exploded = false

# он немного большеватый
func _ready() -> void:
	await get_tree().process_frame
	$DamageArea.monitoring = false
	$ShakeArea.monitoring = false
	$PlayerDamageArea.monitoring = false
	var dist = global_position.distance_to(target)
	var tween = create_tween()
	tween.tween_property(self, "global_position", target, (dist*1.1)/SPEED).set_trans(Tween.TRANS_EXPO).set_ease(Tween.EASE_OUT)
	await tween.finished
	var tween2 := create_tween()
	tween2.tween_property($Sprite2D, "offset", Vector2(-5.7,6), 0.1).set_trans(Tween.TRANS_CUBIC)
	tween2.parallel().tween_property($Sprite2D, "rotation", deg_to_rad(15), 0.1).set_trans(Tween.TRANS_CUBIC)
	await tween2.finished 
	
	$AnimationPlayer.play("grenade_land")
func explode():
	$AnimatedSprite2D.play("explosion")
	exploded = true
	
	$CollisionShape2D.disabled = true
	$Sprite2D.visible = false
	$DamageArea.add_to_group("grenade_boom")
	$DamageArea.monitoring = true
	$PlayerDamageArea.monitoring = true
	$ShakeArea.monitoring = true
	
	await get_tree().process_frame
	$AudioStreamPlayer2D.pitch_scale = randf_range(0.83, 1.12)
	$AudioStreamPlayer2D.play()
	await $AudioStreamPlayer2D.finished
	queue_free()


func _on_damage_area_body_entered(body: Node2D) -> void:
	print(body)
	if exploded and $AnimatedSprite2D.is_playing():
		if body.is_in_group("zondre_juice"):
			player.SCORE += 1
			body.queue_free()

func _on_shake_area_body_entered(body: Node2D) -> void:
	if exploded and $AnimatedSprite2D.is_playing():
		if body.name == "player":
			body.shake = true

func _on_player_damage_area_body_entered(body: Node2D) -> void:
	if exploded and $AnimatedSprite2D.is_playing():
		if body.name == "player":
			body.HEALTH -= 20


func _on_timer_timeout() -> void:
	explode()
