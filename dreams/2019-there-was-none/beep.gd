extends Node

var fade_melody2 : float = -15
var fade_pitch : float = -10

func _physics_process(_delta: float) -> void:
	if fade_pitch > -80:
		fade_pitch -= 0.02
	if fade_melody2 > -80:
		fade_melody2 -= 0.01
	Beeper.plerp({
		"melody2": fade_melody2,
		"pitch": fade_pitch,
	})
