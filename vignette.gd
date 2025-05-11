extends Sprite2D
@onready var vignettered = $"./VignetteRed"
@onready var anim = $AnimationPlayer
var lowhealth = false

func _process(delta: float) -> void:
	if (lowhealth != false):
		show()
		anim.play("lowhealth_anim")
	else:
		anim.stop()
		hide()
		
