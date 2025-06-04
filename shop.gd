extends Node2D

var COSMICITEMS = [
	{
		"type": "aim",
		"name": tr("$default"),
		"description": tr("$default_aim_desctiption"),
		"default": true,
		"price": 0,
		"sprite": preload("res://Resources/aims/default.png"),
		"ismod": false
	},
	{
		"type": "aim",
		"name": tr("$crossaim"),
		"description": tr("$cross_aim_desctiption"),
		"default": false,
		"price": 50,
		"sprite": preload("res://Resources/aims/cross.png"),
		"ismod": false
	},
	{
		"type": "aim",
		"name": tr("$plusaim"),
		"description": tr("$plus_aim_desctiption"),
		"default": false,
		"price": 50,
		"sprite": preload("res://Resources/aims/plus.png"),
		"ismod": false
	},
	{
		"type": "aim",
		"name": tr("$taim"),
		"description": tr("$t_aim_desctiption"),
		"default": false,
		"price": 50,
		"sprite": preload("res://Resources/aims/aa.png"),
		"ismod": false
	}
	
]

const SHOPITEM = preload("res://shopitem.tscn")


# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	for itemcosmic in ModLoader.MODCOSMICITEMS.size():
		COSMICITEMS.insert(COSMICITEMS.size(), ModLoader.MODCOSMICITEMS[itemcosmic])
		COSMICITEMS[COSMICITEMS.size()-1]["ismod"] = true
	print(COSMICITEMS)
	for sus in COSMICITEMS.size():
		var newbtn = SHOPITEM.instantiate()
		newbtn.INFO = COSMICITEMS[sus]
		newbtn.text = COSMICITEMS[sus]["name"]
		if COSMICITEMS[sus]["ismod"] == true:
			if str(COSMICITEMS[sus]["sprite"]).begins_with("res://"):
				newbtn.icon = load(COSMICITEMS[sus]["sprite"])
			else:
				newbtn.icon = ModLoader.get_mod_img(COSMICITEMS[sus]["sprite"])
		else:
			newbtn.icon = COSMICITEMS[sus]["sprite"]
		
		$CanvasLayer/Control/TextureRect/ScrollContainer/HBoxContainer.add_child(newbtn)
		print(newbtn)

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass


func _on_shopclose_pressed() -> void:
	get_tree().change_scene_to_file("res://menu.tscn")
	pass
