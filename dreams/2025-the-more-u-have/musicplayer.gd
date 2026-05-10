extends Node

const CustomLoopPlayer = preload("res://beeper/custom_loop_player.gd")

var reverse : bool = false
var reverse_point : float = 0.0
var reverse_period : float = 0.0

func _physics_process(_delta: float) -> void:
	Beeper.plerp({
		"library":-15
	})
func _process(delta: float) -> void:
	if reverse:
		reverse_period -= delta
		if reverse_period < 0:
			reverse_period += 0.2
			var libraryPlayer : CustomLoopPlayer = Beeper.get_node("library")
			#var pos := libraryPlayer.get_playback_position()
			#pos -= delta * 2
			#if pos < libraryPlayer.custom_loop_start_late:
				#pos += libraryPlayer.stream.get_length() - libraryPlayer.custom_loop_start_late - libraryPlayer.custom_loop_end_reduce
			#libraryPlayer.play(pos)
			libraryPlayer.play(reverse_point)

func _on_viewfollow_storey_changed() -> void:
	reverse = true
	var libraryPlayer : CustomLoopPlayer = Beeper.get_node("library")
	reverse_point = libraryPlayer.get_playback_position()
	reverse_period = 0.0

func _on_viewfollow_storey_change_ended() -> void:
	reverse = false
