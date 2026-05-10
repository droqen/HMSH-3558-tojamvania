extends Node2D

func _physics_process(_delta: float) -> void:
	var p := NavdiSolePlayer.GetPlayer(self)
	if p:
		p.position.x = fposmod(p.position.x, 300) # x wrap only
		#p.position.y = fposmod(p.position.y, 160)
