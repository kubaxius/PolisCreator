extends "../with_gravity.gd"

func _ready():
	pass

func handle_input(event):
	.handle_input(event)
	if event.is_action_pressed("jump"):
		emit_signal("finished", "Jump")