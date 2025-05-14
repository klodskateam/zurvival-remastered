extends Window

var URL = "https://kteam.veliona.no/secret.html"
var STR = "Вы хотите открыть ссылку \"%s\"?"
# var STR = tr("$openlink")

func _ready() -> void:
	$Panel/VBoxContainer/ScrollContainer/desc.text = STR % URL


func _on_button_pressed() -> void:
	OS.shell_open(URL)
	queue_free()

func _on_button_2_pressed() -> void:
	queue_free()


func _on_close_requested() -> void:
	queue_free()
