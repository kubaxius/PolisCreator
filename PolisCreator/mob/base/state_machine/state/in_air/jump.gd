extends "in_air.gd"

export(int) var jump_acceleration = 1100

func enter():
	.enter()
	owner.motion.y = -jump_acceleration
	
func update(delta):
	.update(delta)