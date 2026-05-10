extends Node2D

@export var targetdream : NavdiDream

func _physics_process(_delta: float) -> void:
	var p := NavdiSolePlayer.GetPlayer(self)
	if is_instance_valid(p):
		if p.position.y > 330:
			p.queue_free()
			await get_tree().create_timer(1.0).timeout
			Dreamer.dream(targetdream)
		elif p.position.y > 315:
			$"../viewfollow".permaleaving = true
		elif p.position.y > 240 and p.vy > 0:
			p.airjumps = 0
