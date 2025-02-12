extends Button


func _on_pressed() -> void:
	$"../../../game/player".shoot()



func _on_button_sprint_toggled(toggled_on: bool) -> void:
	if toggled_on:
		Input.action_press("run")
	if !toggled_on:
		Input.action_release("run")


func _on_button_reload_button_down() -> void:
	Input.action_press("reload")
func _on_button_reload_button_up() -> void:
	Input.action_release("reload")
