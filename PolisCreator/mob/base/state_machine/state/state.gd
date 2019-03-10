"""
State interface for Mobs
"""

extends Node

var pushdown := false

signal finished(next_state_name)

func enter():
	pass

func exit():
	pass
	
func update(delta):
	#gravity
	owner.motion.y += owner.gravitational_acceleration
	owner.motion = owner.move_and_slide(owner.motion, owner.up)

func event_map_changed(event_map: Array):
	event_map.has("use_teleport")
	pass
	
func use():
	pass

func check_if_possible():
	pass