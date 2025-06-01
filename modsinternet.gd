extends Control

@onready var internet: HTTPRequest = $HTTPRequest


var API_URL = "http://kteam.veliona.no/_game_services/zr2.0/mods/api/getmods.php"
const MOD_ITEM_INTERNET = preload("res://mod_item_internet.tscn")

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	internet.request(API_URL)
	download("https://kteam.veliona.no/_game_services/zr2.0/mods/files/sus.zip", "user://sus.zip")

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass


func _on_http_request_request_completed(result: int, response_code: int, headers: PackedStringArray, body: PackedByteArray) -> void:
	if response_code == 200:
		var mods_info = JSON.parse_string(body.get_string_from_utf8())
		$Panel/HSplitContainer/ScrollContainer/VBoxContainer/Label.queue_free()
		for mod in mods_info["data"]:
			var new_mod_item = MOD_ITEM_INTERNET.instantiate()
			new_mod_item.NAME = mod["name"]
			new_mod_item.DESC = mod["description"]
			load_image(mod["icon"], new_mod_item)
				
		
			$Panel/HSplitContainer/ScrollContainer/VBoxContainer.add_child(new_mod_item)
			print(mod)
	elif response_code == 0:
		$Panel/HSplitContainer/ScrollContainer/VBoxContainer/Label.text = "Не получилось получить список модов, у вас (по мнению экстрасэнса зомбу) отключён интернет."
	else:
		$Panel/HSplitContainer/ScrollContainer/VBoxContainer/Label.text = "Не получилось получить список модов, код ответа: %s. Проверьте подключение к интернету или доступность адреса \"kteam.veliona.no\"." % str(response_code)
		


func load_image(url: String, target_node: Node) -> void:
	var http_request = HTTPRequest.new()
	add_child(http_request)
	http_request.request_completed.connect(_on_image_loaded.bind(http_request, target_node))
	http_request.request(url)

func _on_image_loaded(result, code, headers, body, request, target_node):
	if result == HTTPRequest.RESULT_SUCCESS:
		var image = Image.new()
		var error = image.load_png_from_buffer(body)
		
		if error == OK:
			var texture = ImageTexture.create_from_image(image)
			target_node.icon.texture = texture
			print(image)
			print(target_node)
	
	request.queue_free()


func _on_close_requested() -> void:
	queue_free()
	
func download(url : String, target : String):
	var download_file = target
	$HTTPRequest2.request(url)
