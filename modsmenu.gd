extends Node2D


# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass

# ука хули не робит 😡😡😡
func _on_open_dir_button_down() -> void:
	OS.execute("start", ["\"\"", OS.get_user_data_dir()])
	OS.execute("start", [OS.get_user_data_dir()])
