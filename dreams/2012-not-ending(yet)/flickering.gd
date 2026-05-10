extends Node2D

var flickering : int = 50

func _physics_process(_delta: float) -> void:
	if flickering > 0:
		visible = randf() < 0.4
		flickering -= 1
	else:
		show()
