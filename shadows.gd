extends Polygon2D

# 25/10/26

func _ready() -> void:
	if Global.SHADOWS == false:
		queue_free()
	if GamemodeManager.GAMEMODE == -1:
		if GamemodeManager.MODGAME.has("shadows_disabled"):
			if GamemodeManager.MODGAME["shadows_disabled"] == true:
				queue_free()
		if GamemodeManager.MODGAME.has("shadows_direction"):
			material.set_shader_parameter("angle", float(GamemodeManager.MODGAME["shadows_direction"]))
		else:	
			pass
		if GamemodeManager.MODGAME.has("shadows_color"):
			material.set_shader_parameter("color", Color(GamemodeManager.MODGAME["shadows_color"][0], GamemodeManager.MODGAME["shadows_color"][1], GamemodeManager.MODGAME["shadows_color"][2], GamemodeManager.MODGAME["shadows_color"][3]))
		else:	
			pass
		if GamemodeManager.MODGAME.has("shadows_distance"):
			material.set_shader_parameter("max_dist", float(GamemodeManager.MODGAME["shadows_distance"]))
		else:	
			pass		
