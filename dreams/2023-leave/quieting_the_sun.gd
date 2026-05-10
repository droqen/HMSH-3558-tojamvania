extends Node2D

func _physics_process(_delta: float) -> void:
	Beeper.plerp({},0.01)
