extends Node2D
@onready var maze : Maze = $"../Maze"
@onready var v : NavdiVessel = $"../v"
func _physics_process(_delta: float) -> void:
	var p := NavdiSolePlayer.GetPlayer(self)
	if p :
		var pcell := maze.local_to_map(p.position)
		match maze.get_cell_tid(pcell):
			47, 68,69, 78,79, 88,89:
				maze.set_cell_tid(pcell,0)
				var pcellpos := maze.map_to_local(pcell)
				for i in 4:
					v.spawn_exile_by_name("glassShard", self).setup(pcellpos,i)
