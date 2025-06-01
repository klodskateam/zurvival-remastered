extends Sprite2D

# тут был костыль HACK HACK HACK (kteam.veliona.no/korzina/index.php?file=paste_683c3701ef2285.34850194.txt)

var BGTIME = 0
var BGs = [
	{
		"image": preload("res://bgs/1.png"),
		"author": "mw10b1909" 
	},
	{
		"image": preload("res://bgs/2.png"),
		"author": "mw10b1909" 
	},
	{
		"image": preload("res://bgs/3.png"),
		"author": "mw10b1909" 
	},
	{
		"image": preload("res://bgs/4.png"),
		"author": "mw10b1909" 
	},
	{
		"image": preload("res://bgs/5.png"),
		"author": "mw10b1909" 
	},
	{
		"image": preload("res://bgs/6.png"),
		"author": "mw10b1909" 
	},
	{
		"image": preload("res://bgs/7.png"),
		"author": "mw10b1909" 
	},
	{
		"image": preload("res://bgs/8.png"),
		"author": "mw10b1909" 
	},
	{
		"image": preload("res://bgs/9.png"),
		"author": "mw10b1909" 
	},
	{
		"image": preload("res://bgs/10.png"),
		"author": "mw10b1909" 
	}
]
var current_image
# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	for img in ModLoader.MODBGIMAGES:
		var imgg = ModLoader.get_mod_img(img["image"])
		
		BGs.insert(BGs.size(), {
			"image": imgg,
			"author": img["author"]
		})
	
	change_image(0)

	
	
func _process(delta: float) -> void:
	BGTIME += delta # люблю костыли
	if BGTIME >= 5:
		BGTIME -= 5
		change_image(current_image)


func change_image(current):
	var bgid = randi_range(0, BGs.size())-1
	while bgid == current:
		bgid = randi_range(0, BGs.size())-1
	texture = BGs[bgid]["image"]
	$Label.text = tr("$createdby") + " " + BGs[bgid]["author"]
	current_image = bgid
	
