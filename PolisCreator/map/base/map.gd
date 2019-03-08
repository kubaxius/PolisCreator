extends Node2D

#checks if object with given height will fit on a tile 
func can_it_fit(height: int, pos: Vector2) -> bool:
	
	var tile_map = $Ground
	
	if not tile_map.walkable_tiles.has(tile_map.get_cellv(Vector2(pos.x, pos.y + 1))):
		return false
	
	for cell_y in range(height):
		if tile_map.get_cellv(pos + Vector2(0, -cell_y)) != -1:
			return false
	return true