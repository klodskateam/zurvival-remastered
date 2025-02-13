extends CanvasLayer


# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	hide()

func set_scores():
	$Panel/VBoxContainer/scores.text = tr("$score") + ": " + str($"../player".SCORE)


func _on_go_to_menu_pressed() -> void:
	get_tree().paused = false
	get_tree().change_scene_to_file("res://menu.tscn")
