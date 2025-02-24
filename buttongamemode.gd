extends Button

var SCENE = "a"

func _on_pressed() -> void:
	get_tree().change_scene_to_file(SCENE)
