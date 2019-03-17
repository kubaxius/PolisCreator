extends "res://mob/person/base/base_person.gd"

var home: Node2D
var workplace: Node2D

func _ready():
	pass

func _process(delta):
	if not is_instance_valid(home):
		find_home()

func find_home():
	var buildings = get_tree().get_nodes_in_group("residential_buildings")
	for building in buildings:
		if building.inhabitants.size() < building.capacity:
			home = building
			home.inhabitants.append(self)