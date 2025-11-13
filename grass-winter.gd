extends Sprite2D

func _ready():
	var time = Time.get_datetime_dict_from_system()
	var month = time["month"]
	if month >= 12 or month <= 01:
		texture = load("res://Resources/snow.png")
	else:
		pass
