extends Node2D

var s : float = 0.00
var p : float = 0.00
@export var pulse_power : float = 0.1
@export var starting_scale : float = 0.01
@export var scale_rate : float = 0.01
@export var rotation_rate : float = 0.01

func _ready() -> void:
	s = starting_scale + 1
	_physics_process(0)

func _physics_process(_delta: float) -> void:
	p += 0.1
	s += scale_rate
	if s < 0: hide(); scale = Vector2(0,0)
	else: show(); scale = Vector2(s,s) * (1+pulse_power*sin(p))
	rotation += rotation_rate
