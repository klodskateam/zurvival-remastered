extends Label


# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	text = "Zurvival Remastered, ver " + Global.VERSION + "\nRunning on " + OS.get_name() + " " + OS.get_version() + " (" + OS.get_model_name() + ").\nCPU: " + OS.get_processor_name() + "\n"
