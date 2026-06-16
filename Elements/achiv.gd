extends Panel

@onready var icon: TextureRect = $HBoxContainer/TextureRect
@onready var title: Label = $HBoxContainer/VBoxContainer/Label
@onready var desc: Label = $HBoxContainer/VBoxContainer/Label2
@onready var animation_player: AnimationPlayer = $AnimationPlayer

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	animation_player.play("in")
	await get_tree().create_timer(2.5).timeout
	animation_player.play("out")
	await get_tree().create_timer(1.5).timeout
	queue_free()

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass
