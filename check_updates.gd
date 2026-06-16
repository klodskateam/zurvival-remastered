extends CheckButton

var sus = 0
var config = ConfigFile.new()
# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	config.load(Global.SAVE_PATH)
	if config.get_value("settings", "ignoreupd") != [2147483647,2147483647,2147483647]:
		button_pressed = false
	else: 
		button_pressed = true


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass


func _on_toggled(toggled_on: bool) -> void:
	match toggled_on:
		true:
			sus = [2147483647,2147483647,2147483647]
		false:
			sus = [0,0,0]
	config.set_value("settings", "ignoreupd", sus)
	config.save(Global.SAVE_PATH)
