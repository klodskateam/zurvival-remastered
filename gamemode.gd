extends Node2D

const BUTTONGAMEMODE = preload("res://buttongamemode.tscn")

var GAMEMODES = [
	{
		"name": tr("$standardmodename"),
		"description": tr("$standardmodedesc"),
		"scene": "res://game.tscn",
	}
]


# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	for sus in GAMEMODES.size():
		var newbtn = BUTTONGAMEMODE.instantiate()
		newbtn.text = GAMEMODES[sus]["name"]
		newbtn.SCENE = GAMEMODES[sus]["scene"]
		
		$UI/Control/Panel/ScrollContainer/VBoxContainer.add_child(newbtn)

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass


func _on_button_pressed() -> void:
	get_tree().change_scene_to_file("res://menu.tscn")
