extends Area2D

func _on_body_entered(body: Node2D):
	if body.name == "player": 
		body.ZAPAS_BULLETS += 12
		body.pickedup = true
		queue_free()

	
