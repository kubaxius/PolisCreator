extends StaticBody2D

export(NodePath) var destination_teleport

var destination_pos setget , _get_destination_pos

func _ready():
	pass

func _get_destination_pos():
	if destination_teleport:
		return get_node(destination_teleport).global_position
	else:
		return false
		
func teleport(node):
	node.global_position = _get_destination_pos()