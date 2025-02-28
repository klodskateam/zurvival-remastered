extends Node

const MODERROR = preload("res://windows/moderror.tscn")

func moderror(text):
	var win = MODERROR.instantiate()
	
	win.DESC = text
	
	add_child(win)
	
