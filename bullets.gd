extends Area2D




func _on_body_entered(body: Node2D):
	if body.name == "player": 
		body.ZAPAS_BULLETS += 12
		queue_free()
	
