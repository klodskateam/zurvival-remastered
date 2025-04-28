extends Node

const MODERROR = preload("res://windows/moderror.tscn")
const ALERT = preload("res://windows/alert.tscn")

func moderror(text):
	var win = MODERROR.instantiate()
	win.DESC = text
	add_child(win)
	
func alert(text):
	var win = ALERT.instantiate()
	win.DESC = text
	win.title = tr("$message")
	add_child(win)
	
