extends Node2D

@export var next_dream : NavdiDream

func _physics_process(_delta: float) -> void:
	var p := NavdiSolePlayer.GetPlayer(self)
	var pcell : Vector2i = $Maze.local_to_map(p.position)
	if $Maze.get_cell_tid(pcell) == 99:
		Dreamer.dream(next_dream)
