extends "on_ground.gd"

export(int) var walk_speed = 400

func enter():
	owner.get_node("AnimationPlayer").play("walk")

func update(delta):
	.update(delta)
	
	var move_right = owner.event_map.find("move_right")
	var move_left = owner.event_map.find("move_left")
	
	if move_left > move_right:
		owner.motion.x = -walk_speed
		if owner.direction != owner.DIRECTION_LEFT:
			owner.direction = owner.DIRECTION_LEFT
	elif move_left < move_right:
		owner.motion.x = walk_speed
		if owner.direction != owner.DIRECTION_RIGHT:
			owner.direction = owner.DIRECTION_RIGHT
	else:
		emit_signal("finished", "Idle")