extends Node

var MODCOSMICITEMS = []
var MODBGIMAGES = []
var MODSLIST

const MOD_IMG_ERROR = preload("res://mod_img_error.png")

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	load_mods()

func load_mods() -> void:
	MODSLIST = DirAccess.get_files_at("user://mods/")
	
	for sus in MODSLIST.size():
		var filepath = "user://mods/" + MODSLIST[sus]
		var file = FileAccess.open(filepath, FileAccess.READ)
		var json = JSON.new()
		var tmp_mod = json.parse_string(file.get_as_text())
		
		print(str(tmp_mod))
		
		if tmp_mod == null:
			var modpath = "user://mods/" + MODSLIST[sus]
			ErrorManager.moderror("Error in " + modpath)
		else:
			for sussy in tmp_mod["adds"].size():
				if tmp_mod["adds"][sussy]["type"] == "aim":
					MODCOSMICITEMS.insert(MODCOSMICITEMS.size(), tmp_mod["adds"][sussy])
				if tmp_mod["adds"][sussy]["type"] == "bgimage":
					MODBGIMAGES.insert(MODBGIMAGES.size(), tmp_mod["adds"][sussy])
		print("MOD COSMETIC:")
		print(MODCOSMICITEMS)
		
		print("MOD BGs:")
		print(MODBGIMAGES)
		
		print("--")
	
# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass

func get_mod_img(path):
	var file = FileAccess.open(path, FileAccess.READ)
	if not file:
		return ModLoader.MOD_IMG_ERROR

	var image_data = file.get_buffer(file.get_length())
	file.close()

	var image = Image.new()
	var error: Error
	if path.get_extension().to_lower() == "png":
		error = image.load_png_from_buffer(image_data)
	elif path.get_extension().to_lower() in ["jpg", "jpeg"]:
		error = image.load_jpg_from_buffer(image_data)
	else:
		return ModLoader.MOD_IMG_ERROR

	if error != OK:
		return ModLoader.MOD_IMG_ERROR

	var texture = ImageTexture.create_from_image(image)
	return texture
