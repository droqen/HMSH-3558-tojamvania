extends Node2D

@export var view : NavdiViewRect # it's a control

var targetstorey : int = 0

func _physics_process(_delta: float) -> void:
	var p := NavdiSolePlayer.GetPlayer(self)
	if p :
		var storeyf = (p.position.y - 95) / 70.0
		var storeyi = round(storeyf)
		if abs(storeyf - storeyi) < 0.1:
			targetstorey = min(2,storeyi)
		view.position.y = move_toward(view.position.y, targetstorey * 70 - 1, 1)
