extends TextureRect

var bluramount = 0
var hp_bluramount = 0
var finalbluramount = 0

func _process(delta: float) -> void:
	if bluramount > 0:
		bluramount -= 10*delta
	finalbluramount = clamp(bluramount + hp_bluramount, 0, 70)
	material.set_shader_parameter("blur_amount", finalbluramount)
