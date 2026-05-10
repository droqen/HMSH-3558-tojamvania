extends Node

func _physics_process(_delta: float) -> void:
	var p := NavdiSolePlayer.GetPlayer(self)
	if p and p.position.y < -5:
		p.queue_free()
		Dreamer.dream(load("res://dreams/2023-leave/2023-leave_Dream.tres"))
