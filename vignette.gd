extends Sprite2D
@onready var vignettered = $"./VignetteRed"
@onready var anim = $AnimationPlayer
var lowhealth = false

func tweenthis(thing : bool):
	if !thing:
		create_tween().tween_property(self, "modulate:a", 1, 1.2)
	else:
		create_tween().tween_property(self, "modulate:a", 0, 1.2)
	pass

func _process(delta: float) -> void:
	if (lowhealth != false):
		tweenthis(0)
		anim.play("lowhealth_anim")
	else:
		anim.stop()
		tweenthis(1)
		
