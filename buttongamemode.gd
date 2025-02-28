extends Button

var SCENE = "a"

var GMNAME = null
var GMDESC = null

func _on_pressed() -> void:
	#get_tree().change_scene_to_file(SCENE)
	
	# ну ваще тут можно было это всё в функцию передать но я осознал это только сейчас лол (а переделовать лень😭😭😭)
	
	$"../../../../../..".GMNAME = GMNAME
	$"../../../../../..".GMDESC = GMDESC
	$"../../../../../..".GMCHANGE_TO = SCENE
	
	$"../../../../../..".change_info()
