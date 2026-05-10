extends Node

func _ready() -> void:
	for sound in get_children():
		sound.volume_db = -80
		sound.play()

func plerp(bgmvols:Dictionary, rate:float=0.1) -> void:
	for sound in get_children():
		var target : float = bgmvols.get(sound.name, -80)
		sound.volume_db = lerp(sound.volume_db,target,rate)
