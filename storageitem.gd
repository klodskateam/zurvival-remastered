extends Button

var Iicon = ""
var Ititle = ""

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	icon = load(Iicon)
	text = Ititle


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass
