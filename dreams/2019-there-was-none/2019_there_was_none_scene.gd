extends Node2D

func _ready() -> void:
	_physics_process(0)

var lastvischars : int = 0

func _physics_process(_delta: float) -> void:
	var p := NavdiSolePlayer.GetPlayer(self)
	if p:
		$Label.visible_ratio = p.position.x / 300
	else:
		$Label.visible_ratio = randf()
	var vch : int = $Label.visible_characters
	if lastvischars != vch:
		var bksp : bool = vch < lastvischars
		lastvischars = vch
		var charat = $Label.text[lastvischars]
		match charat:
			' ', '\n':
				pass
			_:
				Beeper.get_sfx("bksp" if bksp else "type").play()
