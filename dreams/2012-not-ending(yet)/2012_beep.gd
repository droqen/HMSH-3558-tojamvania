extends Node
func _physics_process(_delta: float) -> void:
	var p := NavdiSolePlayer.GetPlayer(self)
	var drums : AudioStreamPlayer = Beeper.get_node("drums")
	if p and not p.visible:
		if drums: drums.pitch_scale = 1.0
		Beeper.plerp({},1)
	else:
		var e := Exit2026.GetExit(self)
		var pitch_limit : float = 2.0
		if e and e.dist_to_player < 100:
			pitch_limit = remap(e.dist_to_player,4,100,1.0,2.0)
		if drums:
			drums.pitch_scale = min(drums.pitch_scale+0.002,pitch_limit)
		Beeper.plerp({"drums":-10},0.02)
