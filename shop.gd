extends Node2D

var COSMICITEMS = [
	{
		"type": "aim",
		"name": tr("$default"),
		"default": true,
		"price": 0,
		"sprite": preload("res://Resources/aims/default.png"),
		"ismod": false
	},
	{
		"type": "aim",
		"name": tr("$crossaim"),
		"default": false,
		"price": 50,
		"sprite": preload("res://Resources/aims/cross.png"),
		"ismod": false
	},
	{
		"type": "aim",
		"name": tr("$plusaim"),
		"default": false,
		"price": 50,
		"sprite": preload("res://Resources/aims/plus.png"),
		"ismod": false
	},
	{
		"type": "aim",
		"name": tr("$taim"),
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
		newbtn.text = COSMICITEMS[sus]["name"]
		if COSMICITEMS[sus]["ismod"] == true:
			if str(COSMICITEMS[sus]["sprite"]).begins_with("res://"):
				load(COSMICITEMS[sus]["sprite"])
			else:
				var imagenew = Image.new()
				imagenew.load(COSMICITEMS[sus]["sprite"])
				var textimg = ImageTexture.new()
				textimg.create_from_image(imagenew)
				newbtn.icon = imagenew
		else:
			newbtn.icon = COSMICITEMS[sus]["sprite"]
		
		$CanvasLayer/Control/ScrollContainer/HBoxContainer.add_child(newbtn)
		print(newbtn)

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass
