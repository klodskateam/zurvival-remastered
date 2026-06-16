extends Node

const ACHIV = preload("res://Elements/achiv.tscn")

var achivs = [
	{
		"name": "Тестовое достижение",
		"description": "Вы достигли чего-то, это, вроде, круто.",
		"icon": preload("res://Resources/i_knew_it.jpg"),
		"completed": false
	}
]

func _input(event: InputEvent) -> void:
	if event.is_action_pressed("devGetAchiv"):
		if Global.devMode:
			giveAchiv(0)
	
# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	refreshAchiv()

func refreshAchiv() -> void:
	var comp: Array
	var CONFIG = ConfigFile.new()
	CONFIG.load(Global.SAVE_PATH)
	
	comp = CONFIG.get_value("save", "completedAchiv", [])
	for achiv in comp:
		achivs[achiv]["completed"] = true

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass
	
	
func giveAchiv(id: int) -> void:
	if !achivs[id]["completed"]:
		var newAchiv = ACHIV.instantiate()
		get_tree().current_scene.add_child(newAchiv)
		newAchiv.position.x = 413.0
		newAchiv.title.text = achivs[id]["name"]
		newAchiv.desc.text = achivs[id]["description"]
		newAchiv.icon.texture = achivs[id]["icon"]
		
		var comp: Array = []
		var CONFIG = ConfigFile.new()
		CONFIG.load(Global.SAVE_PATH)
		
		comp = CONFIG.get_value("save", "completedAchiv", [])
		comp.append(id)
		CONFIG.set_value("save", "completedAchiv", comp)
		CONFIG.save(Global.SAVE_PATH)
		refreshAchiv()
	else:
		print("Достижение уже выполнено")
	
	

	
