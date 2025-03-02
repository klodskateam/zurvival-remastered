extends Node2D

const BUTTONGAMEMODE = preload("res://buttongamemode.tscn")

var GMCHANGE_TO = null
var GMNAME = null
var GMDESC = null

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
		newbtn.GMNAME = GAMEMODES[sus]["name"]
		newbtn.GMDESC = GAMEMODES[sus]["description"]
		newbtn.SCENE = GAMEMODES[sus]["scene"]
		
		$UI/Control/Panel/ScrollContainer/VBoxContainer.add_child(newbtn)

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	if GMCHANGE_TO == null:
		$UI/Control/Panel/PlayButton.disabled = true
	else:
		$UI/Control/Panel/PlayButton.disabled = false


func _on_button_pressed() -> void:
	get_tree().change_scene_to_file("res://menu.tscn")


func _on_play_button_pressed() -> void:
	get_tree().change_scene_to_file(GMCHANGE_TO)
	
func change_info():
	$UI/Control/Panel/gamemodename.text = str(GMNAME)
	$UI/Control/Panel/gamemodedesc.text = str(GMDESC)
