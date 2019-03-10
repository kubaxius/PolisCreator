"""
State interface for Mobs
"""

extends Node

var pushdown := false
var gravitational_acceleration = 40

signal finished(next_state_name)

func enter():
	pass

func exit():
	pass
	
func update(delta):
	#gravity
	owner.motion.y += gravitational_acceleration
	owner.motion = owner.move_and_slide(owner.motion, owner.up)

func event_map_changed(event_map: Array):
	#using elements of environment
	if owner.event_map.has("use"):
		var colliders = Tool.check_for_colliders(owner.position)
		for collider in colliders:
			if collider.is_in_group("usable"):
				collider.use(owner)