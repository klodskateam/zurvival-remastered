extends Area2D


func _on_body_entered(body: Node2D):
	if body.name == "player": 
		if body.HEALTH <= 95:
			body.HEALTH += 5
			queue_free()
