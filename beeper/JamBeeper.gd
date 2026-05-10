extends Node

const CustomLoopPlayer = preload("res://beeper/custom_loop_player.gd")

func _ready() -> void:
	for sound in get_children():
		if sound is CustomLoopPlayer:
			sound.volume_db = -80
			sound.play()

func plerp(bgmvols:Dictionary, rate:float=0.1) -> void:
	for sound in get_children():
		if sound is CustomLoopPlayer:
			var target : float = bgmvols.get(sound.name, -80)
			sound.volume_db = lerp(sound.volume_db,target,rate)

func get_sfx(sfxname:String) -> AudioStreamPlayer:
	var s = get_node_or_null(sfxname)
	if s is CustomLoopPlayer: push_error("can't get sfx %s it's a CustomLoopPlayer" % sfxname); return null;
	elif s is AudioStreamPlayer: return s
	else: push_error("can't get sfx %s it doesn't exist" % sfxname); return null; 
