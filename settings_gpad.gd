#cool script
extends Range

func _ready():
	value = Global.GAYPAD_AIDS

func _on_value_changed(value):
	Global.GAYPAD_AIDS = value
