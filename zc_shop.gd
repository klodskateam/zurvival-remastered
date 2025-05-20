extends Label

var ZC = Global.ZCOINS

func _process(delta: float) -> void:
	ZC = Global.ZCOINS
	text = (str(ZC) + " Z$") 
