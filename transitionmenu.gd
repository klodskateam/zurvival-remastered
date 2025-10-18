extends Control
signal imfinished
var to = 0
@onready var background = get_tree().current_scene.get_node("Background/Sprite2D")
@onready var transitionblock = get_tree().current_scene.get_node("TransitionBlock")
func up(to: int):
	if !Global.SmoothTransitions:
		imfinished.emit(to)
	else:
		if to == 4:
			var blackscreen = get_tree().current_scene.get_node("BlackScreen")
			var tween = create_tween()
			tween.tween_property(blackscreen, "position", Vector2(0, -1008.0), 0.58).set_trans(Tween.TRANS_QUINT)
			tween.connect("finished", func(): up_done(to))
		var tween = create_tween()
		tween.tween_property(self, "position", Vector2(640.0, -520), 0.58).set_trans(Tween.TRANS_QUINT)
		transitionblock.visible = true
		if to == 4:
			pass 
		else:
			tween.connect("finished", func(): up_done(to))
	
	
func up_done(to: int):
	transitionblock.visible = false
	imfinished.emit(to)

func down(to: int):
	if !Global.SmoothTransitions:
		imfinished.emit(to)
	else:
		var tween = create_tween()
		tween.tween_property(self, "position", Vector2(640.0, 1000), 0.58).set_trans(Tween.TRANS_QUINT)
		transitionblock.visible = true
		tween.connect("finished", func(): down_done(to))
	
func down_done(to: int):
	transitionblock.visible = false
	imfinished.emit(to)

func left(to: int):
	if !Global.SmoothTransitions:
		imfinished.emit(to)
	else:
		var tween = create_tween()
		transitionblock.visible = true
		tween.tween_property(self, "position", Vector2(-400, 360), 0.58).set_trans(Tween.TRANS_QUINT)
		tween.connect("finished", func(): left_done(to))
		
func left_done(to: int):
	transitionblock.visible = false
	imfinished.emit(to)

func right(to: int):
	if !Global.SmoothTransitions:
		imfinished.emit(to)
	else:
		var tween = create_tween()
		transitionblock.visible = true
		tween.tween_property(self, "position", Vector2(1500, 360), 0.58).set_trans(Tween.TRANS_QUINT)
		tween.connect("finished", func(): right_done(to))
		
func right_done(to: int):
	transitionblock.visible = false
	imfinished.emit(to)
	
func center():
	if !Global.SmoothTransitions:
		imfinished.emit()
		transitionblock.visible = false
	else:
		var tween = create_tween()
		transitionblock.visible = true
		tween.tween_property(self, "position", Vector2(640, 360), 0.58).set_trans(Tween.TRANS_QUINT)
		tween.connect("finished", func(): center_done())
	
func center_done():
	transitionblock.visible = false
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
	if Global.BGID and Global.SmoothTransitions:
		background.set_id(Global.BGID)
	else:
		pass
	if Global.FROM != 0 and Global.SmoothTransitions:
		from(Global.FROM)
		center()
		Global.FROM = 0
	else:
		position = Vector2(640.0, 360.0)


func _on_visibility_changed2() -> void:
	pass # Replace with function body.
