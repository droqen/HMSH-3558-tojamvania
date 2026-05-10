extends Label

func _ready() -> void:
	if not visible: queue_free()

var loip := 0
func _physics_process(_delta: float) -> void:
	loip += 1
	if loip > 80:
		visible = loip % 40 < 20
	else:
		hide()
