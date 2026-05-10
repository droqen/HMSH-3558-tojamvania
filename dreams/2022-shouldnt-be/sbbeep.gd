extends Node

var eduration : int = 0
var planded : bool = false

func get_coords() -> Vector2i:
	return get_parent().coords

func _physics_process(_delta: float) -> void:
	var p := NavdiSolePlayer.GetPlayer(self)
	var e := Exit2026.GetExit(self)
	if e:
		if p and not p.visible:
			Beeper.plerp({
				"melody2": -15,
				"pitch": -10,
				"drums": 0,
			},1)
		else:
			if eduration < 100:
				eduration += 1
			Beeper.plerp({
				"drums": -10,
				"melody1": -10,
				"pitch": remap(abs(e.position.x-p.position.x), 50,0,-60,-10),
			},0.1)
	elif p:
		var player_edge : float = 150
		if get_coords().x == 2: player_edge = 0
		var dist_to_edge : float = abs(p.position.x - player_edge)
		Beeper.plerp({
			"drums": remap(dist_to_edge,150,0,0,-10),
			"melody1": remap(dist_to_edge,80,0,-60,-10),
		},0.1)
