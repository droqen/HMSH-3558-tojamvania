extends Node2D

var prog := 0
var play := 0
var etype := 0
var tshow := 0

func _ready() -> void:
	Beeper.reset_all_bgms()
	$eytppi.visible_characters = 0
	$pi_title_wht.hide()
	if Dreamer.r("started_previously"):
		pass
	else:
		Viewer.get_node("UiLayer").hide()
		prog = 64
		$slab3.text = ($slab3.text as String).replace("PLAY AGAIN?", "PRESS START")

func _physics_process(_delta: float) -> void:
	if $eytppi.visible_characters < $eytppi.get_total_character_count():
		if etype < 3:
			etype += 1
		else:
			match $eytppi.text[$eytppi.visible_characters]:
				' ', '\n':
					pass
				_:
					Beeper.get_sfx("type").play()
			$eytppi.visible_characters += 1
			etype = 0
	elif tshow < 20:
		tshow += 1
		Beeper.get_sfx("type").play()
	elif tshow < 40:
		tshow += 1
		$pi_title_wht.visible = randf() < 0.8
	else:
		$pi_title_wht.show()
	
	Beeper.plerp({
		
	},0.01)
	prog += 1
	match prog:
		060: $slab1.show()
		063: $slab1/ColorRect.hide()
		120: $slab2.show()
		123: $slab2/ColorRect.hide()
		180: $slab3.show()
		183: $slab3/ColorRect.hide()
		240: $credits.show()
		243: $credits/ColorRect.hide()
	if prog >= 320:
		if prog < 340: $credits_wht.visible = randf() < 0.8
		else: $credits_wht.show()
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
