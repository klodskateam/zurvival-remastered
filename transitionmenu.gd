extends Node2D

@onready var background: Node2D = $Background/CanvasLayer/Sprite2D
@onready var current_scene = $menu
@onready var next_scene

# хотел долгое время переделать переходы
# rip старый transitionmenu.gd 13.07.2025-31.10.2026

func _ready() -> void:
	current_scene.get_node("Control").position = Vector2(get_viewport().get_visible_rect().size.x/2,get_viewport().get_visible_rect().size.y/2)
	get_tree().root.size_changed.connect(movepanel)
	pass

func doit(where: Vector2, nextscene: String, nextfrom: Vector2):
	if Global.SmoothTransitions:
		get_viewport().gui_disable_input = true
		var tween = create_tween()
		var x_transition = (get_viewport().get_visible_rect().size.x/2) - where.x * ((get_viewport().get_visible_rect().size.x+current_scene.get_node("Control/Panel").size.x+30)/2)
		var y_transition = (get_viewport().get_visible_rect().size.y/2) - where.y * ((get_viewport().get_visible_rect().size.y+current_scene.get_node("Control/Panel").size.y+30)/2)
		tween.tween_property(current_scene.get_node("Control"), "position", Vector2(x_transition, y_transition), 0.58).set_trans(Tween.TRANS_QUINT)
		#await tween.finished
		var nextpanel = load("res://" + nextscene + ".tscn").instantiate()
		next_scene = nextpanel
		x_transition = (get_viewport().get_visible_rect().size.x/2) - nextfrom.x * ((get_viewport().get_visible_rect().size.x+nextpanel.get_node("Control/Panel").size.x+30)/2)
		y_transition = (get_viewport().get_visible_rect().size.y/2) - nextfrom.y * ((get_viewport().get_visible_rect().size.y+nextpanel.get_node("Control/Panel").size.y+30)/2)
		nextpanel.get_node("Control").position = Vector2(x_transition, y_transition)
		add_child(nextpanel)
		if nextscene != "menublackscreen":
			var nexttween = create_tween()
			nexttween.tween_property(next_scene.get_node("Control"), "position", Vector2(get_viewport().get_visible_rect().size.x/2,get_viewport().get_visible_rect().size.y/2), 0.58).set_trans(Tween.TRANS_QUINT)
			await tween.finished
			current_scene.queue_free()
			await nexttween.finished
			get_viewport().gui_disable_input = false
			current_scene = next_scene
			next_scene = null
		else:
			var nexttween = create_tween()
			nexttween.tween_property(next_scene.get_node("Control"), "position", Vector2(640, -1368), 0.58).set_trans(Tween.TRANS_QUINT)
			await tween.finished
			current_scene.queue_free()
			get_tree().quit()
	elif !Global.SmoothTransitions:
		current_scene.queue_free()
		if nextscene != "menublackscreen":
			background.change_image()
		var nextpanel = load("res://" + nextscene + ".tscn").instantiate()
		add_child(nextpanel)
		#nextpanel.position = Vector2(get_viewport().get_visible_rect().size.x/2,get_viewport().get_visible_rect().size.y/2)
		next_scene = nextpanel
		if nextscene == "menublackscreen":
			get_tree().quit()
		current_scene = next_scene
		next_scene = null

func movepanel():
	if current_scene != null:
		current_scene.get_node("Control").position = Vector2(get_viewport().get_visible_rect().size.x/2,get_viewport().get_visible_rect().size.y/2)
	pass
