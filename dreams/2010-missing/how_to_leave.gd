extends Node

@onready var sc = $"../sun_center"
@onready var sc2 = $"../sun_center2"

var waitasecond : int = 0

func _physics_process(_delta: float) -> void:
	var p := NavdiSolePlayer.GetPlayer(self)
	if p:
		if p.position.y < -5:
			p.queue_free()
		#Dreamer.dream(load("res://dreams/2023-leave/2023-leave_Dream.tres"))
	else:
		sc.scale_rate -= 0.001 * 0.01
		sc.rotation_rate -= 0.006 * 0.01
		sc2.scale_rate -= 0.001 * 0.01
		sc2.rotation_rate -= 0.006 * 0.01
		if sc.rotation_rate < 0:
			var basss : AudioStreamPlayer = Beeper.get_node("sunnyB")
			var violn : AudioStreamPlayer = Beeper.get_node("sunnyV")
			var synth : AudioStreamPlayer = Beeper.get_node("sunnyS")
			var paads : AudioStreamPlayer = Beeper.get_node("sunnyP")
			var sunstruments = [basss, violn, synth, paads]
			for si in sunstruments:
				si.pitch_scale *= 1.00 + (0.1 * sc.rotation_rate)
		if sc2.s < 0:
			$"../Maze".hide()
			$"../FlickeringMaze".hide()
			waitasecond += 1
			if waitasecond == 120:
				Dreamer.dream(load("res://dreams/2023-leave/2023-leave_Dream.tres"))
