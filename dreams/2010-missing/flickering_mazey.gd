extends Node

@export var maze : Maze
@export var litmaze : Maze

const LIGHT : Dictionary = {
	9 : [8,9,9],
	8 : [6,8,9],
	6 : [5,6,8],
	5 : [1,5,6],
	1 : [2,1,5],
	2 : [2,2,1],
}

var phase := 0

func _physics_process(_delta: float) -> void:
	if phase > 0:
		phase -= 1
	else:
		for cell in maze.get_used_cells_by_tids(LIGHT.keys()):
			var la = LIGHT.get(maze.get_cell_tid(cell),[2,2,2])
			litmaze.set_cell_tid(cell, la[randi()%3])
		phase = randi_range(20,40)
