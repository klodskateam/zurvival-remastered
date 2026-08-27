extends Area2D
signal pickedup_medkit

func _ready() -> void:
	if GamemodeManager.GAMEMODE == 4:
		$Sprite2D.texture = load("res://Resources/repairkit.png")

func _on_body_entered(body: Node2D):
	if body.name == "player": 
		if body.HEALTH <= body.MAX_HEALTH-10:
			body.HEALTH += 10
			body.pickedup_medkit = true
			queue_free()
	if body.is_in_group("vehicle"):
		if body.HP <= body.MAX_HP-10:
			body.HP += 10
			body.driver.pickedup_medkit = true
			queue_free()
