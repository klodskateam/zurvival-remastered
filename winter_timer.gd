extends Timer
@onready var campfire = $"../Campfire"
@onready var player = $"../player" 
func _on_timeout() -> void:
		if campfire.ENERGY <= 0:
			player.COLDNESS += 5
			pass
