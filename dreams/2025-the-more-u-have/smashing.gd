extends Node2D
@onready var maze : Maze = $"../Maze"
@onready var v : NavdiVessel = $"../v"

func _ready() -> void:
	var p := NavdiSolePlayer.GetPlayer(self)
	if p :
		p.vx = -1
		p.vy = -0.1
		p.facedir = -1
		var pcell := maze.local_to_map(p.position)
		var pcellpos := maze.map_to_local(pcell)
		var breaksound := Beeper.get_sfx("break")
		var pitch := breaksound.pitch_scale
		if breaksound.playing and breaksound.get_playback_position() < 1.0:
			pitch += 0.15
		else:
			pitch = randf_range(.5,.7)
		breaksound.pitch_scale = pitch
		breaksound.play()
		await get_tree().process_frame
		for i in 4:
			v.spawn_exile_by_name("glassShard", self).setup(pcellpos,i)
func _physics_process(_delta: float) -> void:
	var p := NavdiSolePlayer.GetPlayer(self)
	if p :
		var pcell := maze.local_to_map(p.position)
		match maze.get_cell_tid(pcell):
			47, 68,69, 78,79, 88,89:
				maze.set_cell_tid(pcell,0)
				var pcellpos := maze.map_to_local(pcell)
				p.freeze(5)
				if pcell.y == 19:
					Beeper.get_sfx("break2").play()
					p.airjumps = 0
					p.vx = 0
					p.vy = 0
					#$"../musicplayer".nomusic = true
				else:
					var breaksound := Beeper.get_sfx("break")
					var pitch := breaksound.pitch_scale
					if breaksound.playing and breaksound.get_playback_position() < 1.0:
						pitch += 0.15
					else:
						pitch = randf_range(.5,.7)
					breaksound.pitch_scale = pitch
					breaksound.play()
				
				for i in 4:
					v.spawn_exile_by_name("glassShard", self).setup(pcellpos,i)
