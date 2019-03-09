extends "with_gravity.gd"

export(int) var jump_acceleration = 1100
export(float) var jump_maneuverability = 0.02
export(float) var mid_air_friction := 0.01

func _ready():
	pass

func enter():
	owner.motion.y = -jump_acceleration
	.enter()
	
func update(delta):
	.update(delta)
	var momentum = lerp(owner.motion.x, 0, mid_air_friction) 
	var user_input = jump_maneuverability * owner.movement_direction
	if owner.motion.y < 0:
		user_input *= -owner.motion.y
	else:
		user_input *= owner.motion.y
	
	owner.motion.x = momentum + user_input
	
	if owner.is_on_floor():
		emit_signal("finished", "previous")