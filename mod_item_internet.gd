extends HBoxContainer

var IMG = preload("res://image_not_found.png")
var NAME = tr("$modnameerror")
var DESC = tr("$moddescerror")
var MOD_ID
@onready var icon: TextureRect = $icon

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	$icon.texture = IMG
	$VBoxContainer/name.text = NAME
	$VBoxContainer/desc.text = DESC
	


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass


func _on_button_pressed() -> void:
	$"../../../../../..".load_mod_info(MOD_ID)
