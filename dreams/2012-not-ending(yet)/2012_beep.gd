extends Node

var pitch_stuck : bool = false
var pitch_pos : float

func _physics_process(_delta: float) -> void:
	var p := NavdiSolePlayer.GetPlayer(self)
	var pitchbgm : AudioStreamPlayer = Beeper.get_node("pitch")
	if p and not p.visible:
		if pitchbgm: pitchbgm.pitch_scale = 1.0
		if not pitch_stuck:
			pitch_stuck = true
			pitch_pos = (pitchbgm
			.get_playback_position())
		else:
			pitchbgm.play(pitch_pos)
			Beeper.plerp({"pitch":-10})
	else:
		var e := Exit2026.GetExit(self)
		var pitch_limit : float = 2.0
		if e and e.dist_to_player < 100:
			pitch_limit = remap(e.dist_to_player,4,100,1.0,2.0)
		if pitchbgm:
			pitchbgm.pitch_scale = min(pitchbgm.pitch_scale+0.002,pitch_limit)
		#Beeper.get_node("pitch").pitch_scale = pitch_limit
		Beeper.plerp({"pitch":-10},0.001)
		#Beeper.plerp({"drums":-10},0.02)
