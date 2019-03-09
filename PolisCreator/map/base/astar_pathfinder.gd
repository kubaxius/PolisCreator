extends Node

onready var astar_node = AStar.new()
export(int) var max_steps = 300

var points_indexes = {}
var iterator = 0

func _ready():
	owner = get_parent()
	pass

func v2tov3(v2: Vector2) -> Vector3:
	return Vector3(v2.x, v2.y, 0)

func v3tov2(v3: Vector3) -> Vector2:
	return Vector2(v3.x, v3.y)

	
"""Checks if object with given height can stand on a passed position. 

It takes into consideration tiles under given position
and tiles that would block object with given height.

Args:
	tpos (Vector2): Position to check.
	theight (int): Height of object that we are checking.

Returns:
	bool: True if object can fit on a tile, false otherwise.
""" 
func can_it_stand_here(tpos: Vector2, theight: int) -> bool:

	var tile_map = $"../Ground"

	#Check if tile that we want to stand on even gives us a posibility to do so.
	if not tile_map.walkable_tiles.has(tile_map.get_cellv(Vector2(tpos.x, tpos.y + 1))):
		return false

	#Check if we fit over tile that we want to stand on.
	for cell_y in range(theight):
		if tile_map.get_cellv(tpos + Vector2(0, -cell_y)) != -1:
			return false

	return true

"""Checks for possible movements from given position.

It uses can_it_stand_here function to find out if places
given in predicted_possible_moves are possible to reach.

Args:
	vpos (Vector2): Position to check.
	vheight (int): Height of object that we are checking.
	predicted_possible_moves (PoolVector2Array, optional): List of predefined moves that we want to check.
		If not set check every surrounding tile.
	can_use_teleports (bool, optional): Can object use teleports.
	
Return:
	PoolVector2Array: List of tile positions where object can move.
	
"""
func where_can_move(vpos: Vector2, vheight: int, predicted_possible_moves = [], can_use_teleports := false) -> PoolVector2Array:
	var tpos = owner.vector_to_tile_pos(vpos)
	var possible_moves = []
	var theight = ceil(vheight/owner.tile_size)
	
	if predicted_possible_moves.size() > 0:
		for move in predicted_possible_moves:
			if can_it_stand_here(move + tpos, theight):
				possible_moves.append(move + tpos)
	else:
		#If predicted_possible_moves are undefined just check every neighboring cell.
		for x in range(-1, 2):
			for y in range(-1, 2):
				var move = Vector2(x, y)
				if move != Vector2(0,0) and can_it_stand_here(move+tpos, theight):
					possible_moves.append(move+tpos)
	
	if can_use_teleports:
		var teleport = owner.get_teleport(vpos)
		if teleport and teleport.destination_pos:
			possible_moves.append(owner.vector_to_tile_pos(owner.get_teleport(vpos).destination_pos))
	
	return possible_moves

"""Adds point to A* list, and connect it to its A* index by adding it to points_indexes list.

Main goal of this function is to have a way to get point index by its vector.

Args:
	point (Vector2): Point to add to A*. 
"""
func add_point_to_astar(point: Vector2):
	astar_node.add_point(iterator, v2tov3(point))
	points_indexes[point] = iterator
	iterator += 1

"""Main function of this node. Is used to find path between two points.

Args:
	vstart (Vector2): Starting position.
	vend (Vector2): Finish position.
	vheight (int): Height of object that we are checking.
	predicted_possible_moves (PoolVector2Array, optional): List of predefined moves that we want to check.
		If not set check every surrounding tile.
	can_use_teleports (bool, optional): Can object use teleports.
	
Return:
	PoolVector2Array: If path exists returns points of it, otherwise returns empty list.
"""
func get_tile_path(vstart: Vector2, vend: Vector2, vheight: int, predicted_possible_moves = [], can_use_teleports := false) -> PoolVector2Array:
	
	$DebugLine.points = []
	
	var tstart = owner.vector_to_tile_pos(vstart)
	var tend = owner.vector_to_tile_pos(vend)
	
	var to_check = [tstart]
	add_point_to_astar(tstart)
	var point
	var to_add = []
	var path = []
	
	var found = false
	var i = 0

	"""
	While loop that keep iterating until:
		-max number of steps is reached
		-finish is found
		-there is no more tiles to check
	"""
	while i < max_steps and not found and to_check.size() > 0:
		point = to_check.pop_front()
		
		to_add = where_can_move(
				point*owner.tile_size + Vector2(owner.tile_size/2, owner.tile_size/2),
				vheight,
				predicted_possible_moves,
				can_use_teleports)
		
		for next_point in to_add:
			if !(points_indexes.has(next_point)):
				to_check.push_back(next_point)
				add_point_to_astar(next_point)
				astar_node.connect_points(points_indexes[point], points_indexes[next_point])
				if next_point == tend:
					found = true
		i += 1
	
	if found:
		for point in astar_node.get_point_path(points_indexes[tstart], points_indexes[tend]):
			path.append(v3tov2(point))
			$DebugLine.add_point(v3tov2(point) * owner.tile_size + Vector2(owner.tile_size/2, owner.tile_size/2))
	
	#Clear global variables.
	iterator = 0
	points_indexes = {}
	astar_node.clear()
	
	return path