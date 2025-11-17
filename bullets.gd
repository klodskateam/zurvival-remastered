extends Area2D
signal pickedup

func _on_body_entered(body: Node2D):
	if body.name == "player": 
		body.ZAPAS_BULLETS += 12
		pickedup.emit()
		queue_free()

	
