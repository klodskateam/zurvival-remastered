extends Node

const MODERROR = preload("res://windows/moderror.tscn")

const ALERT = preload("res://windows/alert.tscn")
const OPENURL = preload("res://windows/openurl.tscn")
const OPENFILE = preload("res://windows/openfile.tscn")

func moderror(text):
	var win = MODERROR.instantiate()
	win.DESC = text
	add_child(win)
	
func alert(text):
	var win = ALERT.instantiate()
	win.DESC = text
	win.title = tr("$message")
	add_child(win)
	
func openurl(url):
	var win = OPENURL.instantiate()
	win.URL = url
	add_child(win)
	
func openfile(file):
	var win = OPENFILE.instantiate()
	win.FILE = file
	add_child(win)
	
