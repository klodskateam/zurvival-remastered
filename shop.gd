extends Node2D

var COSMICITEMS = [
	{
		"type": "aim",
		"name": tr("$default"),
		"default": true,
		"price": 0,
		"sprite": preload("res://Resources/aims/default.png")
	},
	{
		"type": "aim",
		"name": tr("$crossaim"),
		"default": false,
		"price": 50,
		"sprite": preload("res://Resources/aims/cross.png")
	},
	{
		"type": "aim",
		"name": tr("$plusaim"),
		"default": false,
		"price": 50,
		"sprite": preload("res://Resources/aims/plus.png")
	},
	{
		"type": "aim",
		"name": tr("$taim"),
		"default": false,
		"price": 50,
		"sprite": preload("res://Resources/aims/aa.png")
	}
	
]

const SHOPITEM = preload("res://shopitem.tscn")


# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	for sus in COSMICITEMS.size():
		var newbtn = SHOPITEM.instantiate()
		newbtn.text = COSMICITEMS[sus]["name"]
		newbtn.icon = COSMICITEMS[sus]["sprite"]
		
		$CanvasLayer/Control/ScrollContainer/HBoxContainer.add_child(newbtn)

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass
