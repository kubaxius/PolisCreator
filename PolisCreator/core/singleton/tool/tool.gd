extends Node2D

func _ready():
	pass

func check_for_colliders(pos: Vector2) -> Array:
	var space_state = get_world_2d().direct_space_state
	var data =  space_state.intersect_point(pos)
	var objects = []
	for object in data:
		objects.append(object.collider)
	return objects
	
func get_main_scene(scene_name: String) -> Node:
	#check if scene exists
	assert(get_tree().get_nodes_in_group(scene_name).size() != 0)
	return get_tree().get_nodes_in_group(scene_name)[0]

func vector_to_tile_pos(vpos: Vector2) -> Vector2:
	var tpos = Vector2()
	tpos = vpos/get_main_scene("MAP").tile_size
	tpos = (tpos as Vector2).floor()
	
	return tpos