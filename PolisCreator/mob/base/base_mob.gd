extends KinematicBody2D

export(bool) var movable_by_player = false
export(bool) var movable_by_AI = true
export(Vector2) var up = Vector2(0, -1)
export(bool) var can_use_teleports = true

signal event_map_changed(event_map)

var motion := Vector2(0, 0)

# Height of a node in tiles
export(int) var theight = 2

const DIRECTION_LEFT = -1
const DIRECTION_RIGHT = 1

var direction = Vector2(DIRECTION_RIGHT, 1) setget _set_direction, _get_direction

# Remembers which events are pressed.
var event_map = []


func _ready():
	$AI/InputSimulator.connect("simulate_input", self, "_AI_input")

func _AI_input(event):
	if movable_by_AI:
		map_event(event)

func _unhandled_input(event):
	if movable_by_player:
		map_event(event)

func _map_action(event: InputEventAction):
	if not event_map.has(event.action) and event.pressed:
		event_map.append(event.action)
		emit_signal("event_map_changed", event_map)
	elif not event.pressed:
		event_map.erase(event.action)
		emit_signal("event_map_changed", event_map)

func _map_event(event: InputEvent):
	for action_name in InputMap.get_actions():
		if action_name.begins_with("ui_"):
			continue

		if event.is_action(action_name):
			if not event_map.has(action_name) and event.is_pressed():
				event_map.append(action_name)
				emit_signal("event_map_changed", event_map)
			elif not event.is_pressed():
				event_map.erase(action_name)
				emit_signal("event_map_changed", event_map)

func _set_direction(h_direction = DIRECTION_RIGHT):
	var h_dir_mod = h_direction / abs(h_direction) # get unit direction
	apply_scale(Vector2(h_dir_mod * direction.x, 1)) # flip
	direction = Vector2(h_dir_mod, direction.y) # update direction
	
func _get_direction():
	return direction.x

func map_event(event: InputEvent):
	if(event.is_action_type()):
		if(event is InputEventAction):
			_map_action(event)
		else:
			_map_event(event)

func can_i_stand_here(tpos: Vector2) -> bool:
	var map = Tool.get_listed_scene("MAP")
	
	if not map.is_standable(tpos + Vector2(0, 1)):
		return false
	
	for h in range(0, theight+1):
		if not map.is_clear(tpos - Vector2(0, h)):
			return false
	
	return true

func get_possible_moves(tpos: Vector2) -> Array:
	var moves = []
	
	for x in range(-1, 2):
		for y in range(-1, 2):
			if x == 0 and y == 0:
				continue
			if can_i_stand_here(tpos + Vector2(x, y)):
				moves.append(tpos + Vector2(x, y))
				
	if can_use_teleports:
		var teleports_links = PathFinder.teleports_links
		if teleports_links.has(tpos):
			moves.append(teleports_links[tpos])
	return moves