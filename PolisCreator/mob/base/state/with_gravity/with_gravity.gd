extends "../state.gd"

func update(delta):
	owner.motion.y += owner.gravitational_acceleration
	owner.motion = owner.move_and_slide(owner.motion, owner.up)
