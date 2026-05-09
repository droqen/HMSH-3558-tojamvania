extends Node2D

@export var next_dream : NavdiDream

func _physics_process(_delta: float) -> void:
	var p := NavdiSolePlayer.GetPlayer(self)
	var pcell := Vector2i(
		int(p.position.x*0.1),
		int(p.position.y*0.1),
	)
	if pcell == Vector2i(28,14):
		Dreamer.dream(next_dream)
