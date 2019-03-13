extends Node2D

onready var list_of_moves := {}
var iterator := 0
var iterator_max := 1000
var groups_to_check: Array
var teleports_links := {}


func _update_mob(mob: Node2D, group: String):
	var tpos = Tool.vector_to_tile_pos(mob.global_position)
	
	if _check_if_tpos_listed(tpos, group):
		return
	
	
	_add_point_to_astar(tpos, group)
	var to_check = []
	to_check.append(tpos)
	
	while to_check.size() > 0 and iterator < iterator_max:
		tpos = to_check.pop_front()
		var possible_moves = mob.get_possible_moves(tpos)
		
		for move in possible_moves:
			if list_of_moves[group]["to_index"].has(move):
				continue
			_add_point_to_astar(move, group)
			list_of_moves[group]["AStar"].connect_points(list_of_moves[group]["to_index"][tpos], list_of_moves[group]["to_index"][move])
			to_check.append(move)

func _check_if_tpos_listed(tpos: Vector2, group: String) -> bool:
	if list_of_moves.has(group):
			if list_of_moves[group]["to_index"].has(tpos):
				return true
	else:
		list_of_moves[group] = {}
		list_of_moves[group]["to_index"] = {}
		list_of_moves[group]["AStar"] = AStar.new()
	return false

func _add_point_to_astar(point: Vector2, group: String):
	list_of_moves[group]["AStar"].add_point(iterator, v2tov3(point))
	list_of_moves[group]["to_index"][point] = iterator
	iterator += 1

func _get_complex_path(mob: Node, to: Vector2) -> Array:
	var tfrom = Tool.vector_to_tile_pos(mob.global_position)
	var tto = Tool.vector_to_tile_pos(to)
	var path = []
	var path3d = []
	var astar: AStar
	
	for group in groups_to_check:
		
		if mob.is_in_group(group):
			astar = list_of_moves[group].AStar
			
			if list_of_moves[group]["to_index"].has(tfrom) and list_of_moves[group]["to_index"].has(tto):
				path3d = astar.get_point_path(list_of_moves[group]["to_index"][tfrom],
						list_of_moves[group]["to_index"][tto])
			
	for point in path3d:
		path.append(v3tov2(point))
	
	return path

func _simplify_path(path: Array) -> Array:
	var simple_path = []
	var dist_to_prev = 0
	var dist_to_next = 0
	var dist_prev_to_next = 0
	
	if path.size() == 0:
		return []
	
	simple_path.append(path[0])
	
	for i in range(1, path.size() - 1):
		dist_to_prev = path[i].distance_to(path[i-1])
		dist_to_next = path[i].distance_to(path[i+1])
		dist_prev_to_next = path[i-1].distance_to(path[i+1])
		
		#If distance is bigger than 2 that means that you have to use teleport,
		#so it is better to not remove this point from your path 
		if dist_to_next > 2 or dist_to_prev > 2:
			simple_path.append(path[i])
		else:
			if dist_to_next + dist_to_prev != dist_prev_to_next:
				simple_path.append(path[i])
	
	simple_path.append(path[path.size() - 1])
	
	return simple_path

func v2tov3(v2: Vector2) -> Vector3:
	return Vector3(v2.x, v2.y, 0)

func v3tov2(v3: Vector3) -> Vector2:
	return Vector2(v3.x, v3.y)

func update_points():
	teleports_links = Tool.get_teleports_links(true)
	list_of_moves = {}
	iterator = 0
	groups_to_check = ProjectSettings.get_setting("others/environment/mob_pathfinding_groups")
	
	for group in groups_to_check:
		var mobs = get_tree().get_nodes_in_group(group)
		for mob in mobs:
			_update_mob(mob, group)

func get_simple_path(mob: Node, to: Vector2) -> Array:
	var path = _get_complex_path(mob, to)
	var simple_path = _simplify_path(path)
	return simple_path