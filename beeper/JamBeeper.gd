extends Node

const CustomLoopPlayer = preload("res://beeper/custom_loop_player.gd")

func reset_all_bgms() -> void:
	for sound in get_children():
		if sound is CustomLoopPlayer:
			sound.pitch_scale = 1.0
			sound.volume_db = -80
			sound.play(0)

func _ready() -> void:
	reset_all_bgms()

var time_since_last_mix : float = AudioServer.get_time_since_last_mix()

func _physics_process(_delta: float) -> void:
	time_since_last_mix = AudioServer.get_time_since_last_mix()

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
