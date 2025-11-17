extends Area2D
signal pickedup_medkit

func _on_body_entered(body: Node2D):
	if body.name == "player": 
		if body.HEALTH <= 90:
			body.HEALTH += 10
			pickedup_medkit.emit()
			queue_free()
