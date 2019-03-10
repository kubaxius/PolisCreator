extends "in_air.gd"

export(int) var jump_acceleration = 1000

func enter():
	.enter()
	owner.motion.y = -jump_acceleration
	
func update(delta):
	.update(delta)