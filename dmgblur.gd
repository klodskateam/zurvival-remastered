extends TextureRect

var bluramount = 0
var hp_bluramount = 0
var finalbluramount = 0

func _process(delta: float) -> void:
	if bluramount > 0:
		bluramount -= abs(bluramount)-(8*delta)
	finalbluramount = bluramount + hp_bluramount
	material.set_shader_parameter("blur_amount", finalbluramount)
