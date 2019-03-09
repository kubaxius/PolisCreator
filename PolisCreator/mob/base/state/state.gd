"""
State interface for Mobs
"""

extends Node

export var pushdown := false

signal finished(next_state_name)

func enter():
	return

func exit():
	return
	
func update(delta):
	return

func handle_input(event: InputEvent):
	if event.is_action_pressed("move_left"):
		owner.movement_direction = -1
	elif event.is_action_pressed("move_right"):
		owner.movement_direction = 1
	elif event.is_action_released("move_right") and owner.movement_direction == 1:
		owner.movement_direction = 0
	elif event.is_action_released("move_left") and owner.movement_direction == -1:
		owner.movement_direction = 0
	elif event.is_action_pressed("use_teleport"):
		use_teleporter()
	
func use_teleporter():
	if owner.get_map().get_teleport(owner.position):
		owner.get_map().get_teleport(owner.position).teleport(owner)
	pass