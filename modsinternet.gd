extends Control

@onready var internet: HTTPRequest = $HTTPRequest
@onready var modscontainer: VBoxContainer = $Control/Panel/HSplitContainer/ScrollContainer/VBoxContainer

@onready var transition = get_tree().current_scene

# временный URL
var API_URL = Global.KT_URL + "/_api"
const MOD_ITEM_INTERNET = preload("res://mod_item_internet.tscn")
const LOAD_IMG = preload("res://Resources/loading_img.png")
const MOD_IMG_ERROR = preload("res://image_not_found.png")

var mod_idid = 0
var mods_info

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	load_mods(1)
	# INFO ↓↓↓ что это делает? Зачем оно? Мы не знаем, lol ↓↓↓
	# download("https://kteam.veliona.no/_game_services/zr2.0/mods/files/sus.zip", "user://sus.zip")

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass


func _on_http_request_request_completed(result: int, response_code: int, headers: PackedStringArray, body: PackedByteArray) -> void:
	if response_code == 200:
		mods_info = JSON.parse_string(body.get_string_from_utf8())
		$Control/Panel/HSplitContainer/ScrollContainer/VBoxContainer/Label.queue_free()
		
		for mod in mods_info["mods"]:
			var new_mod_item = MOD_ITEM_INTERNET.instantiate()
			new_mod_item.IMG = LOAD_IMG
			new_mod_item.NAME = mod["title"]
			new_mod_item.DESC = mod["content"]
			new_mod_item.MOD_ID = mod["id"]

		
			load_image(mod["iconurl"], new_mod_item, "moditem")
				
		
			$Control/Panel/HSplitContainer/ScrollContainer/VBoxContainer.add_child(new_mod_item)
			print(mod)
	elif response_code == 0:
		$Control/Panel/HSplitContainer/ScrollContainer/VBoxContainer/Label.text = tr("$errorinternetmods0")
	else:
		$Control/Panel/HSplitContainer/ScrollContainer/VBoxContainer/Label.text = tr("$errorinternetmods") % str(response_code)
		


func load_image(url: String, target_node: Node, type: String) -> void:
	var http_request = HTTPRequest.new()
	add_child(http_request)
	http_request.request_completed.connect(_on_image_loaded.bind(http_request, target_node, type))

	http_request.request(url)

func _on_image_loaded(result, code, headers, body, request, target_node, type):
	if result == HTTPRequest.RESULT_SUCCESS:
		var image = Image.new()
		var error = image.load_png_from_buffer(body)
		
		if error == OK:
			var texture = ImageTexture.create_from_image(image)
			if type == "moditem":
				target_node.icon.texture = texture
			elif type == "modinfo":
				target_node.texture = texture
			print(image)
			print(target_node)
		else:
			if type == "moditem":
				target_node.icon.texture = MOD_IMG_ERROR
			elif type == "modinfo":
				target_node.texture = MOD_IMG_ERROR
	
	request.queue_free()


func _on_close_requested() -> void:
	queue_free()
	
func download(url : String, target : String):
	var download_file = target
	$HTTPRequest2.request(url)

func load_mod_info(id):

	mod_idid = id
	#$Control/Panel/HSplitContainer/VSplitContainer/RichTextLabel.text = "\n\n\n[center][tornado]%s[/tornado][/center]" % tr("$loading")
	#
	#http_info.request_completed.connect(dl_mod_info_complete.bind(http_info))
	#http_info.request(API_URL)
	
	dl_mod_info_complete(1, 1, 1, 1, 1) #костыли😨

func dl_mod_info_complete(result, code, headers, body, request):
	
	for mod in mods_info.size():
		if mod == mod_idid:
			$Control/Panel/HSplitContainer/VSplitContainer/RichTextLabel.text = mods_info["data"][mod]["full_description"]
			
			$Control/Panel/HSplitContainer/VSplitContainer/Panel/HBoxContainer/VBoxContainer/modname.text = mods_info["data"][mod]["name"]
			$Control/Panel/HSplitContainer/VSplitContainer/Panel/HBoxContainer/VBoxContainer/moddesc.text = mods_info["data"][mod]["description"]
			
			$Control/Panel/HSplitContainer/VSplitContainer/Panel/HBoxContainer/TextureRect.texture = LOAD_IMG
			load_image(mods_info["data"][mod]["icon"], $Control/Panel/HSplitContainer/VSplitContainer/Panel/HBoxContainer/TextureRect, "modinfo")
			$Control/Panel/HSplitContainer/VSplitContainer/Panel/HBoxContainer/VBoxContainer/dl_btn.disabled = false

func _on_rich_text_label_meta_clicked(meta: Variant) -> void:
	OS.shell_open(str(meta))


func _on_dl_btn_pressed() -> void:
	for mod in mods_info.size():
		if mod == mod_idid:
			$mod_dl.request(mods_info[mod]["file"])
			
			print("Начало загрузки...")
	
	


func _on_mod_dl_request_completed(result: int, response_code: int, headers: PackedStringArray, body: PackedByteArray) -> void:
	var modname = str(randi_range(100, 1000000))
	var dir = DirAccess.open("user://")
	print("Проверка существования папок, создание...")
	if !dir.dir_exists("user://mods"):
		dir.make_dir("user://mods")
	if !dir.dir_exists("user://mods/temp"):
		dir.make_dir("user://mods/temp")
	var file = FileAccess.open("user://mods/temp/temp" + modname + ".zip", FileAccess.WRITE)
	var reader = ZIPReader.new()
	
	if response_code != 200:
		pass
	else:
		print("Успешно загружено, попытка сохранить...")
		file.store_buffer(body)
		file.close()
		print("Сохранено! Попытка распаковать...")
		
		reader.open("user://mods/temp/temp" + modname + ".zip")
		# украдено с документации потому-что я неуч😎😎😎
		var root_dir = DirAccess.open("user://mods/")

		var files = reader.get_files()
		for file_path in files:
			# If the current entry is a directory.
			if file_path.ends_with("/"):
				root_dir.make_dir_recursive(file_path)
				continue
				
			# Write file contents, creating folders automatically when needed.
			# Not all ZIP archives are strictly ordered, so we need to do this in case
			# the file entry comes before the folder entry.
			root_dir.make_dir_recursive(root_dir.get_current_dir().path_join(file_path).get_base_dir())
			var filee = FileAccess.open(root_dir.get_current_dir().path_join(file_path), FileAccess.WRITE)
			var file2 = DirAccess.open("user://mods/temp/")
			var buffer = reader.read_file(file_path)
			filee.store_buffer(buffer)
			filee.close()
			print("Очистка...")
	reader.close()
	print(modname)
	ModLoader.load_mods()
	dir.remove("user://mods/temp/temp" + modname + ".zip")

func load_mods(page: int = 1, clear: bool = false):
	if clear:
		for c in modscontainer.get_children():
			c.queue_free()
		
	var limit = 10 # поставил единицу, потому-что щас только 4 тестовых записи. Не забыть поменять на 10 ОЧЕНЬ СРОЧНО НЕ ЗАБЫТЬ
	var offset: int = (page - 1) * limit
	var url = "/mods?limit=%d&offset=%d&game=%s" % [
		limit, offset, "zr".uri_encode()
	]
	internet.request(API_URL + url)

func _on_quitmodsinternet_pressed() -> void:
#	get_tree().change_scene_to_file("res://mods.tscn")
	#background.save_id()
	#Global.FROM = 2
	#transition.up(3)
	transition.doit(Vector2(0, 1), "mods", Vector2(0,-1))
