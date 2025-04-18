extends Sprite2D
var BGTIME = 0
const BG1 = [
	preload("res://bgs/1.png"),
	"mw10b1909"
]
const BG2 = [
	preload("res://bgs/2.png"),
	"mw10b1909"
]
const BG3 = [
	preload("res://bgs/3.png"),
	"mw10b1909"
]
const BG4 = [
	preload("res://bgs/4.png"),
	"mw10b1909"
]
const BG5 = [
	preload("res://bgs/5.png"),
	"mw10b1909"
]
const BG6 = [
	preload("res://bgs/6.png"),
	"mw10b1909"
]
const BG7 = [
	preload("res://bgs/7.png"),
	"mw10b1909"
]
const images = 7
# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass
	
	
func _process(delta: float) -> void:
	BGTIME += delta # люблю костыли
	if BGTIME >= 5:
		BGTIME -= 5
		if randi_range(1, images) == 1: # хотелось бы рандомнее, а то показывается один фон несколько раз
			texture = BG1[0]
			$Label.text = tr("$createdby") + " " + BG1[1]
		if randi_range(1, images) == 2:
			texture = BG2[0]
			$Label.text = tr("$createdby") + " " + BG2[1]
		if randi_range(1, images) == 3:
			texture = BG3[0]
			$Label.text = tr("$createdby") + " " + BG3[1]
		if randi_range(1, images) == 4:
			texture = BG4[0]
			$Label.text = tr("$createdby") + " " + BG4[1]
		if randi_range(1, images) == 6:
			texture = BG6[0]
			$Label.text = tr("$createdby") + " " + BG6[1]
		if randi_range(1, images) == 7:
			texture = BG7[0]
			$Label.text = tr("$createdby") + " " + BG7[1]

		
