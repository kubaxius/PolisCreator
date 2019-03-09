extends "on_ground.gd"

export(int) var movement_speed = 400

func _ready():
	pass

func enter():
	if not owner.movement_direction:
		emit_signal("finished", "Idle")

func update(delta):
	.update(delta)
	if not owner.movement_direction:
		emit_signal("finished", "Idle")
	else:
		owner.motion.x = movement_speed * owner.movement_direction