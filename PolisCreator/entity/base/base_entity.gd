extends KinematicBody2D

export var gravitational_acceleration: float = 10

var map

func _ready():
	map = get_tree().get_nodes_in_group("MAP")[0]
	pass
