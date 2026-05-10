extends NavdiSolePlayerBasics

enum { LANDEDGREYBUF }

const TINYSCALE = 0.3

var airjumps := 0
var sneaking := false

func _ready() -> void:
	super._ready()
	bufs.setup_bufons([
		FLORBUF,8,
		LANDEDGREYBUF,15,
	])

func _physics_process(_delta: float) -> void:
	var dpad := Pin.get_dpad()
	var onflor := is_on_floor()
	if onflor:
		if airjumps <= 0 and not sneaking: bufs.setmin(LANDEDGREYBUF, 15)
		airjumps = 2
		sneaking = dpad.y > 0
		if sneaking: airjumps = 0
	elif sneaking:
		#if vy >= 0: vx = 0
		sneaking = false
	elif bufs.has(FLORBUF):
		vx = 0
		airjumps = 0
	
	if Pin.get_jump_hit(): bufs.on(JUMPBUF)
	if not onflor and airjumps <= 0:
		if abs(vx) < 0.06:
			tow_vx(facedir+dpad.x, 0.03, 0.005)
	elif sneaking:
		tow_vx(dpad.x, 0.35, 0.05)
	else:
		tow_vx(dpad.x, 0.65, 0.05)
	
	#tow_gravity(1.0,0.030)
	tow_gravity(1.0,0.018,Pin.get_jump_held(),0.028)
	#tow_gravity(1.0,0.015,Pin.get_jump_held(),0.040)

	vx *= TINYSCALE
	vy *= TINYSCALE
	apply_velocities()
	vx /= TINYSCALE
	vy /= TINYSCALE
	
	#position.x = clamp(position.x, -1, 299.5)
	if position.x < -0.75 or position.x > 299.75:
		Dreamer.dreamfresh(load("res://dreams/2023-leave/2023-leave_Dream.tres"))
	
	if bufs.has(LANDEDGREYBUF):
		spr.setup([11],0)
		#vx = 0; vy = 0;
		bufs.on(LANDBUF)
	elif bufs.has(LANDBUF):
		spr.setup([11 if sneaking else 10],0)
	elif bufs.has(TURNBUF):
		spr.setup([11 if sneaking else 10],0)
	elif not onflor:
		if airjumps >= 1:
			spr.setup([10],0)
		else:
			spr.setup([11],0)
	else:
		spr.setup([11 if sneaking else 10],0)
	if bufs.try_eat([FLORBUF,JUMPBUF]):
		vy = -0.9
		Beeper.get_sfx("jump1_quiet").play()
	elif airjumps > 0 and bufs.try_eat([JUMPBUF]):
		airjumps -= 1
		match airjumps:
			0:
				Beeper.get_sfx("jump3_quiet").play()
				if vy < 0:
					vx += facedir * abs(vy)
				vy = -.6
			1:
				Beeper.get_sfx("jump2_quiet").play()
				vy = vy*.33 - 1.1
