extends Node2D

var tile_size = 128
export(Color) var grid_color
export(bool) var draw_grid = false
	
func _draw():
	if draw_grid:
	    draw_set_transform(Vector2(-tile_size*20, -tile_size*20), 0, Vector2(tile_size, tile_size))
	
	    for y in range(0, 100):
	        draw_line(Vector2(0, y), Vector2(tile_size, y), grid_color)
	
	    for x in range(0, 100):
	        draw_line(Vector2(x, 0), Vector2(x, tile_size), grid_color)

func is_clear(tpos: Vector2) -> bool:
	if $Ground.get_cellv(tpos) == -1:
		return true
	else:
		return false

func is_standable(tpos: Vector2) -> bool:
	if $Ground.standable_tiles.has($Ground.get_cellv(tpos)):
		return true
	else:
		return false