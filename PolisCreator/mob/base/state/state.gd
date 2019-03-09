"""
State interface for Mobs
"""

extends Node

var pushdown := false
var motion := Vector2(0, 0)

signal finished(next_state_name)

func enter():
	return

func exit():
	return
	
func update(delta):
	return

func handle_input(event):
	return