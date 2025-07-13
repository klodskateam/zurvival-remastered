extends Control
signal imfinished
var to = 0
@onready var background = get_tree().current_scene.get_node("Background/Sprite2D")

func up(to: int):
	var tween = create_tween()
	tween.tween_property(self, "position", Vector2(640.0, -520), 0.7).set_trans(Tween.TRANS_QUINT)
	tween.connect("finished", func(): up_done(to))
	
	
func up_done(to: int):
	imfinished.emit(to)

func down(to: int):
	var tween = create_tween()
	tween.tween_property(self, "position", Vector2(640.0, 1000), 0.7).set_trans(Tween.TRANS_QUINT)
	tween.connect("finished", func(): down_done(to))
	
func down_done(to: int):
	imfinished.emit(to)

func left(to: int):
	var tween = create_tween()
	tween.tween_property(self, "position", Vector2(-400, 360), 0.7).set_trans(Tween.TRANS_QUINT)
	tween.connect("finished", func(): left_done(to))
		
func left_done(to: int):
	imfinished.emit(to)

func right(to: int):
	var tween = create_tween()
	tween.tween_property(self, "position", Vector2(1500, 360), 0.7).set_trans(Tween.TRANS_QUINT)
	tween.connect("finished", func(): right_done(to))
		
func right_done(to: int):
	imfinished.emit(to)
	
func center():
	var tween = create_tween()
	tween.tween_property(self, "position", Vector2(640, 360), 0.7).set_trans(Tween.TRANS_QUINT)
	tween.connect("finished", func(): center_done())
	
func center_done():
	imfinished.emit()
	
func from(where: int):
	if where == 1:
		position = Vector2(640.0, -520.0)
	elif where == 2:
		position = Vector2(640.0, 1000.0)
	elif where == 3:
		position = Vector2(-400.0, 360.0)
	elif where == 4:
		position = Vector2(1500.0, 360.0)
	
func _ready() -> void:
	if Global.BGID:
		background.set_id(Global.BGID)
	if Global.FROM != 0:
		from(Global.FROM)
		center()
		Global.FROM = 0
	else:
		position = Vector2(640.0, 360.0)
