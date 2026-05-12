extends AudioStreamPlayer
@export var custom_loop_enabled : bool = false
@export var custom_loop_start_late : float = 0.025
@export var custom_loop_end_reduce : float = 0.015
@onready var stream_length := stream.get_length()

func _process(_delta: float) -> void:
	if custom_loop_enabled:
		var gpp : float = get_playback_position() + get_parent().time_since_last_mix
		if gpp >= stream_length - custom_loop_end_reduce:
			seek(custom_loop_start_late)
			print("loop stream %s %.3f seeking to %.3f @ %.3f"%[
				name,
				gpp,
				custom_loop_start_late,
				get_playback_position(),
			])
