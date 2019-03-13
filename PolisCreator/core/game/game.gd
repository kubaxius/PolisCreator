extends Node2D

var map = ""

func _ready():
	map = load(ProjectSettings.get_setting("global/level_to_load"))
	map = map.instance()
	self.add_child(map)
	PathFinder.update_points()
	pass
