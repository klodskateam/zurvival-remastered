extends CanvasLayer
var receivedzc = 0

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	hide()

func set_scores():
	$Panel/VBoxContainer/scores.text = tr("$score") + ": " + str($"../player".SCORE)+", " + tr("$received") + ": " + str(receivedzc) + " Z$"


func _on_go_to_menu_pressed() -> void:
	$"../PauseManager".PAUSE = false
	get_tree().paused = false
	get_tree().change_scene_to_file("res://menu.tscn")
