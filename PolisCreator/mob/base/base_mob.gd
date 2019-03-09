extends KinematicBody2D

export(bool) var movable_by_player = false
export(bool) var movable_by_AI = true
export(int) var gravitational_acceleration = 40
export(Vector2) var up = Vector2(0, -1)
export(BitMap) var movement_bitmap: BitMap
export(Vector2) var position_on_movement_bitmap
export(bool) var can_use_portals = false

var motion := Vector2(0, 0)
var movement_direction: int = 0
var on_ground_friction := 0.2

var possible_moves: PoolVector2Array

func _ready():
	_set_possible_moves()

func _set_possible_moves():
	var moves_array = []
	var bitmap_size: Vector2 = movement_bitmap.get_size()
	for x in range(bitmap_size.x):
		for y in range(bitmap_size.y):
			var bit_pos = Vector2(x, y)
			if movement_bitmap.get_bit(bit_pos):
				moves_array.append(bit_pos - position_on_movement_bitmap)
	possible_moves = moves_array

func get_map():
	#check if map is loaded
	assert(get_tree().get_nodes_in_group("MAP").size() != -1)
	return get_tree().get_nodes_in_group("MAP")[0]