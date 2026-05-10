extends Node

func _physics_process(_delta: float) -> void:
	Beeper.plerp({},0.03) # fade
