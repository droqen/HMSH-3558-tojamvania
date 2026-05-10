extends Node2D

@export var view : NavdiViewRect # it's a control

signal storey_changed
signal storey_change_ended
var storey_changing := false
var permaleaving := false

var _targetstorey : int = 0
var targetstorey : int :
	get : return _targetstorey
	set(v) :
		if _targetstorey != v:
			_targetstorey = v
			if v >= 10:
				storey_changed.emit()
			storey_changing = true

func _physics_process(_delta: float) -> void:
	if permaleaving:
		targetstorey = 10
		view.position.y += 0.6
	else:
		var p := NavdiSolePlayer.GetPlayer(self)
		if p :
			var storeyf = (p.position.y - 95) / 70.0
			var storeyi = round(storeyf)
			if abs(storeyf - storeyi) < 0.1:
				targetstorey = min(2,storeyi)
			if storey_changing:
				var ty = targetstorey * 70 - 1
				view.position.y = move_toward(view.position.y, ty, 1)
				if view.position.y == ty:
					storey_changing = false
					storey_change_ended.emit()
