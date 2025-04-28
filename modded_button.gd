extends Button

var actions

func _ready() -> void:
	pass

func _on_pressed() -> void:
	#print(actions)
	
	for action in actions:
		if "alert" in action:
			ErrorManager.alert(action["alert"])
		if "window" in action:
			if action["window"] == "minimize":
				get_tree().root.mode = Window.MODE_MINIMIZED
			if action["window"] == "maximize":
				get_tree().root.mode = Window.MODE_MAXIMIZED
		if "openurl" in action:
			OS.shell_open(action["openurl"])
		if "execute" in action:
			OS.shell_open(OS.get_user_data_dir() + action["execute"])
