extends "state.gd"

func update(delta):
	motion.y += owner.gravitational_acceleration
	motion = owner.move_and_slide(motion, owner.up)
