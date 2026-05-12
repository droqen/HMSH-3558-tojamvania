extends Node

func _ready() -> void:
	if OS.has_feature("editor") and true:
		Dreamer.debug_mode = true
		Dreamer.dream(load("res://dreams/06-brightgreenmenu/06-brightgreenmenu_Dream.tres"))
	else:
		Dreamer.debug_mode = false
		Dreamer.dream(load("res://dreams/2023-leave/2023-leave_Dream.tres"))
	#Dreamer.navdilog("STATUS", "NO DREAMS FOUND")
	#Dreamer.dream()
