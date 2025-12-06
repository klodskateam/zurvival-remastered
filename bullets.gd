extends Area2D

func _on_body_entered(body: Node2D):
	if body.name == "player": 
		#body.ZAPAS_BULLETS += 12
		if body.WEAPONS[body.SELECTED_WEAPON]["grenade"]:
			body.WEAPONS[body.SELECTED_WEAPON]["zapas_bullets"] += body.WEAPONS[body.SELECTED_WEAPON]["bullets"]*2
		else:
			body.WEAPONS[body.SELECTED_WEAPON]["zapas_bullets"] += body.WEAPONS[body.SELECTED_WEAPON]["bullets"]
		body.pickedup = true
		queue_free()

	
