extends Node2D

var prog := 0
var play := 0

func _ready() -> void:
	if Dreamer.r("started_previously"):
		pass
	else:
		Viewer.get_node("UiLayer").hide()
		prog = 64
		$slab3.text = ($slab3.text as String).replace("PLAY AGAIN?", "PRESS START")

func _physics_process(_delta: float) -> void:
	Beeper.plerp({},0.01)
	prog += 1
	match prog:
		060: $slab1.show()
		063: $slab1/ColorRect.hide()
		120: $slab2.show()
		123: $slab2/ColorRect.hide()
		180: $slab3.show()
		183: $slab3/ColorRect.hide()
	if prog >= 180:
		if Pin.get_action_hit(): play = 1
		if play:
			play += 1
			$slab3.visible = play % 10 < 5
		else:
			$slab3.visible = prog % 60 < 40
	if play > 33:
		Dreamer.dreamfresh(load("res://dreams/2009-scale/2009-scale_Dream.tres"))
		Dreamer.w("started_previously", true)
