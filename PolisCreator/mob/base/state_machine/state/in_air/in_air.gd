extends "../state.gd"

export(float) var in_air_maneuverability = 0.02
export(float) var in_air_friction := 0.01

func _init():
	pushdown = true

func update(delta):
	.update(delta)
	var momentum = lerp(owner.motion.x, 0, in_air_friction)
	
	var move_right = owner.event_map.find("move_right")
	var move_left = owner.event_map.find("move_left")
	var user_input = 0
	
	if move_left > move_right:
		user_input = -1
	elif move_left < move_right:
		user_input = 1
	
	
	if owner.motion.y < 0:
		user_input *= -owner.motion.y
	else:
		user_input *= owner.motion.y
	
	owner.motion.x = momentum + (user_input * in_air_maneuverability)
	
	if owner.is_on_floor():
		emit_signal("finished", "previous")