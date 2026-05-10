extends Node

@onready var sun_center2 = $"../sun_center2"
@onready var sun_center = $"../sun_center"

var t : float = 0.0
var ticker : int = 0

func _physics_process(delta: float) -> void:
	t += delta
	var basss : AudioStreamPlayer = Beeper.get_node("sunnyB")
	var violn : AudioStreamPlayer = Beeper.get_node("sunnyV")
	var synth : AudioStreamPlayer = Beeper.get_node("sunnyS")
	var paads : AudioStreamPlayer = Beeper.get_node("sunnyP")
	var sunstruments = [basss, violn, synth, paads]
	
	#if t > ticker:
		#ticker += 1
		#var sun : AudioStreamPlayer = Beeper.get_node("sun")
		#print(ticker,' ',sun_center.scale.x if sun_center.visible else "-", sun.volume_db)
	var brown : float = sun_center2.scale.x
	var yellow : float = sun_center.scale.x
	if brown < 0.001: brown = 0
	else: brown = min(2,sqrt(brown))*0.5
	if yellow < 0.001: yellow = 0
	else: yellow = min(2,sqrt(yellow))*0.5
	
	if yellow > 0:
		Beeper.plerp({
			"sunnyV":lerp(-30,-20,brown),
			"sunnyB":max(-15,lerp(-40,-10,yellow)),
			"sunnyS":lerp(-25,0,yellow),
			"sunnyP":lerp(-25,0,yellow),
		})
		for si in sunstruments:
			si.pitch_scale += 0.001 * yellow * 0.1
	elif brown > 0:
		Beeper.plerp({
			"sunnyV":lerp(-30,20,brown),
			"sunnyB":lerp(-20, 0,brown),
			#"sunnyS":lerp(0.0,1.0,yellow),
			#"sunnyP":lerp(0.0,1.0,yellow),
		})
	else:
		Beeper.plerp({
			"sunnyV":-30,
		})
		
