extends Area2D


func _on_body_entered(body: Node2D):
	if body.name == "player": 
		if body.HEALTH <= 90:
			body.HEALTH += 10
			queue_free()
