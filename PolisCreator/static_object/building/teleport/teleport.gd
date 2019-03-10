extends StaticBody2D

export(NodePath) var destination_teleport

var destination_pos setget , _get_destination_pos

func _ready():
	shape_owner_set_disabled(0, false)

func _get_destination_pos():
	if destination_teleport:
		return get_node(destination_teleport).get_node("Spawner").global_position
	else:
		return false

func use(node):
	if self.destination_pos:
		node.global_position = self.destination_pos