extends Node

@onready var sun_center = $"../sun_center2"

var t : float = 0.0
var ticker : int = 0

func _physics_process(delta: float) -> void:
	t += delta
	if t > ticker:
		ticker += 1
		print(ticker,' ',sun_center.scale.x if sun_center.visible else "-")
	if sun_center.scale.x > 0:
		var sun : AudioStreamPlayer = Beeper.get_node("sun")
		if sun.pitch_scale < -10:
			sun.play(0)
		Beeper.plerp({"sun":remap(
			sun_center.scale.x,
			0,100,
			-10,10,
		)})
	else:
		Beeper.plerp({})
		
