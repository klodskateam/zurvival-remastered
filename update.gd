extends Panel
@onready var http: HTTPRequest = $HTTPRequest
var cleanCurVer = ""
var cleanNewVer = ""
var arrNewVer = [0, 0, 0]
var newVerUrl = "https://github.com/klodskateam/zurvival-remastered/releases"

var updUrl = "https://api.github.com/repos/klodskateam/zurvival-remastered/releases/latest"
var config = ConfigFile.new()
# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	config.load(Global.SAVE_PATH)
	var regex = RegEx.new()
	regex.compile("(\\d+\\.)+\\d+")
	var result = regex.search(Global.VERSION)
	cleanCurVer = result.get_string()
	http.request(updUrl)
	#OS.alert(cleanCurVer)


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass


func _on_rich_text_label_meta_clicked(meta: Variant) -> void:
	OS.shell_open(str(meta))


func _on_http_request_request_completed(result: int, response_code: int, headers: PackedStringArray, body: PackedByteArray) -> void:
	var data = JSON.parse_string(body.get_string_from_utf8())
	if data != null:
		newVerUrl = data["html_url"]
		var regex = RegEx.new()
		regex.compile("(\\d+\\.)+\\d+")
		var result2 = regex.search(data["name"])
		cleanNewVer = result2.get_string()
		#OS.alert(cleanCurVer)
		var curVer = cleanCurVer.split(".")
		var newVer = cleanNewVer.split(".")
		arrNewVer = [int(newVer[0]), int(newVer[1]), int(newVer[2])]
		var ignoreVer = config.get_value("settings", "ignoreupd", [0,0,0])
		if int(newVer[0]) == int(ignoreVer[0]) and int(newVer[1]) == int(ignoreVer[1]) and int(newVer[2]) == int(ignoreVer[2]):
			print("Версия в списке игнорируемых.")
			return
			
		if int(newVer[0]) > int(curVer[0]):
			show_update(data)
		else:
			if int(newVer[1]) > int(curVer[1]):
				show_update(data)
			else:
				if int(newVer[2]) > int(curVer[2]):
					show_update(data)
				else:
					print("Game up to date!")
		
func show_update(data) -> void:
	#OS.alert("NEW VERSION")
	var regex2 = RegEx.new()
	regex2.compile("<[^>]*>")
	var tteexxtt = regex2.sub(data["body"], "", true)
	$Label/Label.text = data["name"]
	$RichTextLabel.text = tteexxtt
	show()
		
		
	


func _on_update_pressed() -> void:
	OS.shell_open(newVerUrl)


func _on_ignore_this_pressed() -> void:
	
	config.set_value("settings", "ignoreupd", arrNewVer)
	config.save(Global.SAVE_PATH)
	queue_free()


func _on_close_pressed() -> void:
	queue_free()
