extends Area2D

signal invoke_inspector(my_owner, event)

func _ready():
	connect("input_event", self, "_invoke_inspector")
	pass

func _invoke_inspector(viewport, event, shape_idx):
	emit_signal("invoke_inspector", owner, event)