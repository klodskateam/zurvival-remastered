extends Button

var INFO = {}

const PRODUCT_WINDOWS = preload("res://windows/product_windows.tscn")

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass


func _on_pressed() -> void:
	var product_win = PRODUCT_WINDOWS.instantiate()
	if "name" in INFO:
		product_win.PRODUCT_NAME = INFO["type"]
	if "description" in INFO:
		product_win.PRODUCT_DESCTIPTION = INFO["description"]
	else:
		product_win.PRODUCT_DESCTIPTION = tr("$notset")
	if "price" in INFO:
		product_win.PRODUCT_PRICE = int(INFO["price"])
	if "sprite" in INFO:
		if "ismod" in INFO:
			if !INFO["ismod"]:
				product_win.PRODUCT_IMAGE = INFO["sprite"]
			else:
				product_win.PRODUCT_IMAGE = ModLoader.get_mod_img(INFO["sprite"])
	if "type" in INFO:
		product_win.PRODUCT_TYPE = INFO["type"]
	
	$"../../../../..".add_child(product_win)
	print(INFO)
