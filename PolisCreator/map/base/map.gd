extends Node2D

var tile_size = 128

func vector_to_tile_pos(vpos: Vector2) -> Vector2:
	var tpos = Vector2()
	tpos = vpos/tile_size
	tpos = (tpos as Vector2).floor()
	
	return tpos
	
func get_teleport(pos: Vector2):
	var space_state = get_world_2d().direct_space_state
	for object in space_state.intersect_point(pos, 32, [], 2):
		if object.collider.owner.is_in_group("teleports"):
			return object.collider.owner
	return false