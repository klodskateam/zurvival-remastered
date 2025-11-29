extends Area2D

func _on_body_entered(body: Node2D):
	if body.name == "player": 
		#body.ZAPAS_BULLETS += 12
		body.WEAPONS[body.SELECTED_WEAPON]["zapas_bullets"] += body.WEAPONS[body.SELECTED_WEAPON]["bullets"]
		body.pickedup = true
		queue_free()

	
