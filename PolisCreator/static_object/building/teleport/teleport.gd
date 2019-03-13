extends StaticBody2D

export(NodePath) var destination_teleport

var destination_pos setget , _get_destination_pos
#for AI#
var my_pos setget , _get_my_pos
#/for AI#
var is_set setget , _get_is_set


func _ready():
	shape_owner_set_disabled(0, false)


func use(node):
	if self.destination_pos:
		node.global_position = self.destination_pos
		

func _get_destination_pos():
	if destination_teleport:
		return get_node(destination_teleport).get_node("Spawner").global_position
	else:
		return false

func _get_is_set():
	if destination_teleport:
		return true
	else:
		return false
	
func _get_my_pos():
	return $Spawner.global_position