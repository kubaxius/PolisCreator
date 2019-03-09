extends TileMap

export(Array, int) var walkable_tiles = [0]

func _ready():
	pass

	
func get_tile_index(tpos: Vector2):
	var used_rect = get_used_rect()
	if used_rect.has_point(tpos):
		var fixed_tpos = -used_rect.position + tpos
		
		return fixed_tpos.x + used_rect.size.x * fixed_tpos.y
	else:
		#tried to get index of tile that is out of bounds
		assert(false)