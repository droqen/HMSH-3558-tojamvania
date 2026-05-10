extends Node

var eduration : int = 0
var planded : bool = false

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
				"drums": 0,
				"melody1": remap(e.taxidist_to_player,70,10,
					remap(eduration,0,100,-80,-40),
					-15
				),
				"pitch": remap(e.taxidist_to_player, 50,10,-60,-10),
			},0.1)
	else:
		Beeper.plerp({
			"drums": 0,
			#"melody1": 0,
		},0.1)
