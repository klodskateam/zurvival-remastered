extends Window

var DESC = null

func _ready() -> void:
	$Panel/VBoxContainer/desc.text = DESC


func _on_close_requested() -> void:
	queue_free()


func _on_button_pressed() -> void:
	queue_free()
