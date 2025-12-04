extends Node2D

const BUTTONGAMEMODE = preload("res://buttongamemode.tscn")

@onready var transition = get_tree().current_scene.get_node("Control")
@onready var background = get_tree().current_scene.get_node("Background/Sprite2D")
var GMCHANGE_TO = null
var GMNAME = null
var GMDESC = null
var GAMEMODE = null

var GAMEMODES = [
	{
		"name": tr("$classicmodename"),
		"description": tr("$classicmodedesc"),
		"scene": "res://game.tscn",
		"gamemode": 1,
	},
	{
		"name": tr("$standardmodename"),
		"description": tr("$standardmodedesc"),
		"scene": "res://game.tscn",
		"gamemode": 0,
	},
	{
		"name": tr("$wintermodename"),
		"description": tr("$wintermodedesc"),
		"scene": "res://game-wintermode.tscn",
		"gamemode": 2,
	},
]

var MODDED_GAMEMODES = []
var MODGAME = 0
# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	MODDED_GAMEMODES = ModLoader.MODGAMEMODES
	if Global.isDEMO:
		$Control/Panel/ScrollContainer/VBoxContainer/HBoxContainer/ShopButton.text = "Soon..."
		$Control/Panel/ScrollContainer/VBoxContainer/HBoxContainer/StorageButton.text = "Soon..."
		
		$Control/Panel/ScrollContainer/VBoxContainer/HBoxContainer/ShopButton.disabled = true
		$Control/Panel/ScrollContainer/VBoxContainer/HBoxContainer/StorageButton.disabled = true
	
	for sus in GAMEMODES.size():
		var newbtn = BUTTONGAMEMODE.instantiate()
		newbtn.text = GAMEMODES[sus]["name"]
		newbtn.GMNAME = GAMEMODES[sus]["name"]
		newbtn.GMDESC = GAMEMODES[sus]["description"]
		newbtn.SCENE = GAMEMODES[sus]["scene"]
		newbtn.GMODE = GAMEMODES[sus]["gamemode"]
		newbtn.MODGAME = null

		$Control/Panel/ScrollContainer/VBoxContainer.add_child(newbtn)
		
	for susgame in MODDED_GAMEMODES.size():
		var newbtn = BUTTONGAMEMODE.instantiate()
		newbtn.text = "[MOD] " + MODDED_GAMEMODES[susgame]["name"]
		newbtn.GMNAME = MODDED_GAMEMODES[susgame]["name"]
		newbtn.GMDESC = MODDED_GAMEMODES[susgame]["desc"]
		newbtn.SCENE = "res://game-mod.tscn"
		newbtn.MODGAME = susgame
		newbtn.GMODE = -1
		
		$Control/Panel/ScrollContainer/VBoxContainer.add_child(newbtn)
		pass
	if not transition.imfinished.is_connected(Global.got_finishedsign):
		transition.imfinished.connect(Global.got_finishedsign)

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	if GMCHANGE_TO == null:
		$Control/Panel/PlayButton.disabled = true
	else:
		$Control/Panel/PlayButton.disabled = false


func _on_button_pressed() -> void:
#	get_tree().change_scene_to_file("res://menu.tscn")
	background.save_id()	
	Global.FROM = 2
	transition.up(6)
	pass


func _on_play_button_pressed() -> void:
	if MODGAME == null:
		pass
	else:
		GamemodeManager.MODGAME = MODDED_GAMEMODES[MODGAME].duplicate(true)
	get_tree().change_scene_to_file(GMCHANGE_TO)
	
func change_info():
	$Control/Panel/gamemodename.text = str(GMNAME)
	$Control/Panel/gamemodedesc.text = str(GMDESC)


func _on_shopbtn_pressed() -> void:
	get_tree().change_scene_to_file("res://shop.tscn")


func _on_storagebtn_pressed() -> void:
	get_tree().change_scene_to_file("res://storage.tscn")
