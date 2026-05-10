extends Node2D
@export var targetdream : NavdiDream
func _physics_process(_delta: float) -> void:
	var p := NavdiSolePlayer.GetPlayer(self)
	if p and p.position.y > 140:
		Dreamer.dream(targetdream)
