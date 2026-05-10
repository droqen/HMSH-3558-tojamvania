extends Node2D

func _ready() -> void:
	_physics_process(0)

func _physics_process(_delta: float) -> void:
	var p := NavdiSolePlayer.GetPlayer(self)
	if p:
		$Label.visible_ratio = p.position.x / 300
	else:
		$Label.visible_ratio = randf()
