extends Area2D
signal pickedup_medkit

func _on_body_entered(body: Node2D):
	if body.name == "player": 
		if body.HEALTH <= body.MAX_HEALTH-10:
			body.HEALTH += 10
			body.pickedup_medkit = true
			queue_free()
