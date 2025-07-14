extends TextureRect
var a = 0
	
func tweenthis():
	var tween = create_tween()
	tween.tween_method(func(value): material.set_shader_parameter("blur_amount", value), 0.1, 16.0, 1.0).set_trans(Tween.TRANS_SINE)
	pass

func _on_visibility_changed() -> void:
	if visible and Global.SmoothTransitions:
		material.set_shader_parameter("blur_amount", 0.1)
		tweenthis()
	elif !Global.SmoothTransitions:
		material.set_shader_parameter("blur_amount", 16.0)
	else:
		material.set_shader_parameter("blur_amount", 0.0)
