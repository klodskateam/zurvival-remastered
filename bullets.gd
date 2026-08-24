extends Area2D

func _on_body_entered(body: Node2D):
	if body.name == "player": 
		if body.WEAPONS[body.SELECTED_WEAPON]["harmless"] or body.WEAPONS[body.SELECTED_WEAPON]["bullets"] == 0:
			pass
		else:
			#body.ZAPAS_BULLETS += 12
			if body.WEAPONS[body.SELECTED_WEAPON]["type"] == "grenade":
				body.WEAPONS[body.SELECTED_WEAPON]["zapas_bullets"] += body.WEAPONS[body.SELECTED_WEAPON]["bullets"]*2
			else:
				body.WEAPONS[body.SELECTED_WEAPON]["zapas_bullets"] += body.WEAPONS[body.SELECTED_WEAPON]["bullets"]
			body.pickedup = true
			queue_free()
	elif body.is_in_group("vehicle"):
		if body.VEHICLE["weapon"]["bullets"] == 0:
			pass
		else:
			body.VEHICLE["weapon"]["zapas_bullets"] += body.VEHICLE["weapon"]["bullets"]
			body.driver.pickedup = true
			queue_free()

	
