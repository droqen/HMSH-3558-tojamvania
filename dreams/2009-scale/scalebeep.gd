extends Node

func _physics_process(_delta: float) -> void:
	var e := Exit2026.GetExit(self)
	if e and e.dist_to_player < 50:
		#Beeper.plerp("melody1", e.distuv_to_player, "drums")
		var d := {
			"drums":remap(e.dist_to_player,
				50,5,
				-20,-10,
			)}
		#print(e.dist_to_player, ' ', d)
		Beeper.plerp(d)
	else:
		Beeper.plerp({"drums":-20})
		
