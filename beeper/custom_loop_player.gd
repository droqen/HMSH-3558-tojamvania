extends AudioStreamPlayer
@export var custom_loop_start_late : float = 0.025
@export var custom_loop_end_reduce : float = 0.015

func _physics_process(_delta: float) -> void:
	if playing and get_playback_position() > stream.get_length() - custom_loop_end_reduce:
		play(custom_loop_start_late)
