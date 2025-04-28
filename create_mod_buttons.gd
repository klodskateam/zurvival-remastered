extends VBoxContainer

const MODDED_BUTTON = preload("res://modded_button.tscn")
# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	for sus in ModLoader.MODSLIST.size():
		var filepath = "user://mods/" + ModLoader.MODSLIST[sus]
		var file = FileAccess.open(filepath, FileAccess.READ)
		var json = JSON.new()
		var tmp_mod = json.parse_string(file.get_as_text())
		
		for add_item in tmp_mod["adds"]:
			print(add_item)
			if add_item["type"] == "menubutton":
				var new_btn = MODDED_BUTTON.instantiate()
				if "icon" in add_item:
					new_btn.icon = ModLoader.get_mod_img(add_item["icon"])
				if "text" in add_item:
					new_btn.text = add_item["text"]
				else:
					new_btn.text = tr("$modtexterror")
					
				if "actions" in add_item:
					new_btn.actions = add_item["actions"]
				else:
					new_btn.actions = [{"alert": tr("$actionserror")}]
					
				$".".add_child(new_btn)
