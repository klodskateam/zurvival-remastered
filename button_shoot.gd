extends Button


func _on_pressed() -> void:
	$"../../../game/player".shoot()



func _on_button_sprint_toggled(toggled_on: bool) -> void:
	if toggled_on:
		Input.action_press("run")
	if !toggled_on:
		Input.action_release("run")

func _on_button_reload_pressed() -> void:
	$"../../../game/player".bullets_reload()

func _ready() -> void:
	if OS.get_name() != "Android":
		$"..".queue_free()
