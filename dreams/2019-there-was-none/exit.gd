extends Marker2D
class_name Exit2026
const GROUPNAME := &"ExitGrp"
@export var target_dream : NavdiDream
func _ready() -> void:
	add_to_group(GROUPNAME)
static func GetExit(node_in_tree:Node) -> Exit2026:
	return node_in_tree.get_tree().get_first_node_in_group(GROUPNAME) as Exit2026
	# might be null
const MAX_DIST_TO_PLAYER := 100.0
const MAX_DISTSQ_TO_PLAYER := pow(MAX_DIST_TO_PLAYER,2)
var dist_to_player : float = MAX_DIST_TO_PLAYER
var distsq_to_player : float = MAX_DISTSQ_TO_PLAYER
var distuv_to_player : float = 1.0
var taxidist_to_player : float = MAX_DIST_TO_PLAYER
func _physics_process(_delta: float) -> void:
	var p := NavdiSolePlayer.GetPlayer(self)
	if p : 
		distsq_to_player = p.position.distance_squared_to(position)
		taxidist_to_player = max(
			abs(p.position.x - position.x),
			abs(p.position.y - position.y))
		if taxidist_to_player <= 2.9:
			p.hide()
			p.process_mode = Node.PROCESS_MODE_DISABLED
			get_tree().current_scene.process_mode = Node.PROCESS_MODE_DISABLED
			await get_tree().create_timer(1.20).timeout
			if not is_inside_tree(): push_error("exited tree in the meantime whyyy")
			Dreamer.dream(target_dream) # might need to do a transition or whatever
			if is_instance_valid(p):
				p.process_mode = Node.PROCESS_MODE_INHERIT
	else:
		distsq_to_player = MAX_DISTSQ_TO_PLAYER
	if distsq_to_player < MAX_DISTSQ_TO_PLAYER:
		dist_to_player = sqrt(distsq_to_player)
		distuv_to_player = dist_to_player / MAX_DIST_TO_PLAYER
	else:
		dist_to_player = MAX_DIST_TO_PLAYER
		distuv_to_player = 1.0
