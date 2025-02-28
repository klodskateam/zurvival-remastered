extends Node

var MODCOSMICITEMS = []

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	var modslist = DirAccess.get_files_at("user://mods/")
	
	for sus in modslist.size():
		var filepath = "user://mods/" + modslist[sus]
		var file = FileAccess.open(filepath, FileAccess.READ)
		var json = JSON.new()
		var tmp_mod = json.parse_string(file.get_as_text())
		
		print(str(tmp_mod))
		
		if tmp_mod == null:
			var modpath = "user://mods/" + modslist[sus]
			ErrorManager.moderror("Error in " + modpath)
		else:
			var susplus1 = sus + 1
			for sussy in tmp_mod[susplus1]["adds"].size():
				if tmp_mod[susplus1]["adds"][sussy]["type"] == "aim":
					MODCOSMICITEMS.insert(MODCOSMICITEMS.size(), tmp_mod[susplus1]["adds"][sussy])
		print(MODCOSMICITEMS)
		

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass
