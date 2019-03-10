extends KinematicBody2D

export(bool) var movable_by_player = false
export(bool) var movable_by_AI = true
export(int) var gravitational_acceleration = 40
export(Vector2) var up = Vector2(0, -1)
export(bool) var can_use_portals = false

signal event_map_changed(event_map)

var motion := Vector2(0, 0)

# Remembers which events are pressed.
var event_map = []

func _ready():
	$AI.connect("simulate_input", self, "_AI_input")

func get_map():
	#check if map is loaded
	assert(get_tree().get_nodes_in_group("MAP").size() != -1)
	return get_tree().get_nodes_in_group("MAP")[0]

func _AI_input(event):
	if movable_by_AI:
		map_event(event)

func _unhandled_input(event):
	if movable_by_player:
		map_event(event)

func map_event(event: InputEvent):
	if(event.is_action_type()):
		if(event is InputEventAction):
			_map_action(event)
		else:
			_map_event(event)
		
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
