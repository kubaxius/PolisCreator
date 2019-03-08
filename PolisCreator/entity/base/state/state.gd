"""
State interface for Entities
"""

extends Node

var pushdown: bool = false

signal finished(next_state_name)

func enter():
	return

func exit():
	return
	
func update(delta):
	return

func handle_input(event):
	return