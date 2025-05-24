extends Window

var PRODUCT_NAME = "Placeholder"
var PRODUCT_PRICE = 99 # Z$
var PRODUCT_DESCTIPTION = "Это [color=#FF0000]т[/color][color=#FF4800]е[/color][color=#FF9100]с[/color][color=#FFDA00]т[/color][color=#DAFF00]о[/color][color=#91FF00]в[/color][color=#48FF00]ы[/color][color=#00FF00]й[/color] [color=#00FF91]т[/color][color=#00FFDA]е[/color][color=#00DAFF]к[/color][color=#0091FF]с[/color][color=#0048FF]т[/color] [color=#4800FF]т[/color][color=#9100FF]о[/color][color=#DA00FF]в[/color][color=#FF00DA]а[/color][color=#FF0091]р[/color][color=#FF0048]а[/color]. Это описание товара, оно поддерживает [color=#870000]B[/color][color=#65003F]B[/color][color=#43007F]-[/color][color=#2100BF]К[/color][color=#0000FF]о[/color][color=#0026BF]д[/color][color=#004C7F]ы[/color][color=#00723F]![/color]"
var PRODUCT_IMAGE = preload("res://_IMPORTANT_IMAGE_DONT_DELETE_INACHE_PISEC!!.jpg")

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	$Panel/HSplitContainer/VBoxContainer2/Label.text = PRODUCT_NAME
	$Panel/HSplitContainer/VBoxContainer2/RichTextLabel.text = PRODUCT_DESCTIPTION
	$Panel/HSplitContainer/VBoxContainer/Label.text = str(PRODUCT_PRICE) + " Z$"
	$Panel/HSplitContainer/VBoxContainer/TextureRect.texture = PRODUCT_IMAGE


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass


func _on_close_requested() -> void:
	queue_free()


func _on_buyitem_pressed() -> void:
	if Global.ZCOINS >= PRODUCT_PRICE:
		Global.ZCOINS -= PRODUCT_PRICE
		Global.CONFIG.set_value("save", "zcoins", Global.ZCOINS)
		Global.CONFIG.save(Global.SAVE_PATH)
		print(str(Global.ZCOINS))
		queue_free()
