extends Button
var SCENE = "res://shop.tscn"

var GMNAME = null
var GMDESC = null
var GMODE = null
var MODGAME = null
var CHALLENGE = false

func _on_pressed() -> void:
#	get_tree().change_scene_to_file(SCENE)
	
	# ну ваще тут можно было это всё в функцию передать но я осознал это только сейчас лол (а переделовать лень😭😭😭)
	if !CHALLENGE:
		$"../../../../..".GMNAME = GMNAME
		$"../../../../..".GMDESC = GMDESC
		$"../../../../..".GMCHANGE_TO = SCENE
		$"../../../../..".MODGAME = MODGAME
		$"../../../../..".isCHALLENGE = false
		$"../../../../..".change_info()
	else:
		$"../../../../../..".GMNAME = GMNAME
		$"../../../../../..".GMDESC = GMDESC
		$"../../../../../..".GMCHANGE_TO = SCENE
		$"../../../../../..".MODGAME = MODGAME
		$"../../../../../..".isCHALLENGE = true
		$"../../../../../..".change_info()
	GamemodeManager.GAMEMODE = GMODE
	
	
	
