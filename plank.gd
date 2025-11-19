extends Area2D




func _on_body_entered(body: Node2D):
	if body.name == "player" and (body.INVENTORY_FILLED < body.MAX_INVENTORY_FILLED): 
		body.INVENTORY_FILLED += 10
		body.pickedup_plank = true
		queue_free()
	
