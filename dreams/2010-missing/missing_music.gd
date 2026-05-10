extends Node

@onready var sun_center = $"../sun_center2"

var t : float = 0.0
var ticker : int = 0

func _physics_process(delta: float) -> void:
	t += delta
	if t > ticker:
		ticker += 1
		var sun : AudioStreamPlayer = Beeper.get_node("sun")
		print(ticker,' ',sun_center.scale.x if sun_center.visible else "-", sun.volume_db)
	if sun_center.scale.x > 0.001:
		var sun : AudioStreamPlayer = Beeper.get_node("sun")
		if sun.volume_db < -60:
			sun.play(0)
		sun.pitch_scale = clamp(remap(
			sqrt(sun_center.scale.x),
			0.0, 1.0,
			0.2, 1.0,
		),0,2)
		Beeper.plerp({"sun":remap(
			sun_center.scale.x,
			0.0, 3.0,
			-50,10,
		)}, 0.9)
	else:
		Beeper.plerp({})
		
