extends Node2D

@export var coords : Vector2i
@export var roomrect_tiles : Rect2i = Rect2i(0,0,10,10)
@export var stage : Node2D
@export var stage_exiles : Node2D
@export var vessel : NavdiVessel
var roomrect_pixels : Rect2
var stage_maze : Maze
#var stage_exiles : Node2D
func _ready() -> void:
	#stage_exiles = Node2D.new()
	#stage_exiles.name = "exiles"
	#stage.add_child(stage_exiles)
	#stage_exiles.owner = owner if owner else self
	roomrect_pixels = Rect2(
		roomrect_tiles.position as Vector2 * 10.0,
		roomrect_tiles.size as Vector2 * 10.0,
	)
	stage_maze = stage.get_node("Maze") as Maze
	loadroom.call_deferred()
func _physics_process(_delta: float) -> void:
	var p := NavdiSolePlayer.GetPlayer(self)
	if p:
		var traveldir := NavdiGenUtil.gen_oobdir(p.position, roomrect_pixels, -1)
		if traveldir :
			coords += traveldir
			p.position.x -= traveldir.x * (roomrect_pixels.size.x - 4)
			p.position.y -= traveldir.y * (roomrect_pixels.size.y - 4)
			loadroom()
func loadroom() -> void:
	stage_maze.copy_from(
		vessel.get_maze(),
		Rect2i(
			roomrect_tiles.size * coords,
			roomrect_tiles.size,
		),
	)
	vessel.spawn_exiles_by_roomcoords(coords, stage_exiles)
