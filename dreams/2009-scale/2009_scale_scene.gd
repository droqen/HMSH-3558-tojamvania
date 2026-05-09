extends Node2D

func _physics_process(_delta: float) -> void:
	var p := NavdiSolePlayer.GetPlayer(self)
	if p and $Maze.get_cell_tid(
		$Maze.local_to_map(
			p.position
		)
	) == 99:
		Dreamer.dream(load("res://dreams/2022-shouldnt-be/2022-shouldnt-be_Dream.tres"))
