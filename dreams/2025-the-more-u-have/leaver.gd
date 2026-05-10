extends Node2D

@export var targetdream : NavdiDream

func _physics_process(_delta: float) -> void:
	var p := NavdiSolePlayer.GetPlayer(self)
	if p:
		if p.position.y > 240:
			p.airjumps = 0
		if p.position.y > 330:
			p.queue_free()
			await get_tree().create_timer(1.0).timeout
			Dreamer.dream(targetdream)
