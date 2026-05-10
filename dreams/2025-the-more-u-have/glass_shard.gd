extends Node2D

var vx : float ; var vy : float ; var life : int = 0;

func setup(pos,index) -> void:
	position = pos
	vx = -1 if index % 2 == 0 else 1
	vy = -1 if index < 2 else 1
	position += Vector2(vx,vy)*2.5
	vx *= randf()
	vy *= randf()
	vy -= randf()
	life = randi_range(20,30)

func _physics_process(_delta: float) -> void:
	if position.x < 0: position.x += 300
	if position.x > 300: position.x -= 300
	position.x += vx
	position.y += vy
	vy += 0.1
	if life > 0 : life -= 1
	else : queue_free()
