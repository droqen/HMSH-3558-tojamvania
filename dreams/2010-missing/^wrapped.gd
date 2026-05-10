extends Node

func _physics_process(_delta: float) -> void:
	var p = get_parent()
	p.position.x = fposmod(p.position.x, 150)
