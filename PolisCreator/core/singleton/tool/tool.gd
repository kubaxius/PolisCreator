extends Node2D

func _enter_tree():
	get_tree().connect("tree_changed", self, "_tree_changed")

func check_for_colliders(pos: Vector2) -> Array:
	var space_state = get_world_2d().direct_space_state
	var data =  space_state.intersect_point(pos)
	var objects = []
	for object in data:
		objects.append(object.collider)
	return objects
	
func get_listed_scene(scene_name: String) -> Node:
	#check if scene exists
	assert(get_tree().get_nodes_in_group(scene_name).size() != 0)
	return get_tree().get_nodes_in_group(scene_name)[0]

func vector_to_tile_pos(vpos: Vector2) -> Vector2:
	var tpos = Vector2()
	tpos = vpos/get_listed_scene("MAP").tile_size
	tpos = (tpos as Vector2).floor()
	
	return tpos
	
func get_teleports_links(in_tiles := false):
	var teleports = get_tree().get_nodes_in_group("teleports")
	var links = {}
	
	if not in_tiles:
		for teleport in teleports:
			links[teleport.my_pos] = teleport.destination_pos
	else:
		for teleport in teleports:
			if teleport.is_set:
				links[vector_to_tile_pos(teleport.my_pos)] = vector_to_tile_pos(teleport.destination_pos)
			else:
				links[vector_to_tile_pos(teleport.my_pos)] = false
	return links
