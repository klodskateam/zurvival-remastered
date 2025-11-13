extends Area2D




func _on_body_entered(body: Node2D):
	if body.name == "player": 
		body.INVENTORY_FILLED += 10
		queue_free()
	
