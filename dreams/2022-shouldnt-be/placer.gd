extends NavdiSolePlayerBasics

enum { LANDEDGREYBUF }

@onready var staircast : ShapeCast2D = $mover/staircast
var airjumps := 0
var sneaking := false

func _ready() -> void:
	super._ready()
	bufs.setup_bufons([
		FLORBUF,8,
		LANDEDGREYBUF,15,
	])

func _physics_process(_delta: float) -> void:
	show()
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
	
	apply_velocities()
	
	if bufs.has(LANDEDGREYBUF):
		spr.setup([39],0)
		#vx = 0; vy = 0;
		bufs.on(LANDBUF)
	elif bufs.has(LANDBUF):
		spr.setup([39 if sneaking else 19],0)
	elif bufs.has(TURNBUF):
		spr.setup([45 if sneaking else 25],0)
	elif not onflor:
		if airjumps >= 2:
			spr.setup([16],0)
		elif airjumps >= 1:
			spr.setup([26],0)
		elif airjumps >= 0:
			if vy > 0.5: spr.setup([28,29],5)
			elif abs(vx) >= 0.07: spr.setup([27],0)
			else: spr.setup([28],0)
	elif dpad.x:
		if sneaking:
			spr.setup_forcechangeindex([38,39,36,37],11)
		else:
			spr.setup_forcechangeindex([18,19,16,17],8,{16:3})
	else:
		spr.setup([35 if sneaking else 15],0)
	if bufs.try_eat([FLORBUF,JUMPBUF]):
		vy = -0.9
	elif airjumps > 0 and bufs.try_eat([JUMPBUF]):
		airjumps -= 1
		match airjumps:
			0:
				if vy < 0:
					vx += facedir * abs(vy)
				vy = -.6
			1:
				vy = vy*.33 - 1.1

func is_on_floor() -> bool:
	var on_floor : bool = false
	if vy >= 0:
		var cast_to_floor := mover.cast_fraction(self, staircast, VERTICAL, 1)
		if cast_to_floor < 1:
			if cast_to_floor >= .25:
				position.y += cast_to_floor
			on_floor = true
			if not bufs.has(FLORBUF) and not bufs.has(NOLANDBUF): bufs.on(LANDBUF)
			bufs.on(FLORBUF)
	return on_floor

func apply_velocities() -> void:
	if vy<0 and!mover.try_slip_move(self,solidcast,VERTICAL,vy,sign(vx)):
		vy=0 # do vy first if moving up
	if vx<0 and!mover.try_slip_move(self,solidcast,HORIZONTAL,vx,sign(vy)):
		vx=0 # vx left: through stairs
	if vx>0 and!mover.try_slip_move(self,staircast,HORIZONTAL,vx,sign(vy)):
		if mover.try_slip_move(self,solidcast,HORIZONTAL,vx,sign(vy)):
			position.y -= abs(vx)
		else:
			vx=0 # vx right: uppa da stairs
		
	if vy>0 and!mover.try_move(self,staircast,VERTICAL,vy):
		vy=0 # do vy last if moving down - no slip
