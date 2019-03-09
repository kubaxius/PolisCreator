extends Node

var path = []
var direction := Vector2(0, 0)
var current_destination := Vector2(0, 0)

signal simulate_input(Event)

func generate_action(action: String, pressed: bool) -> InputEventAction:
	var new_event = InputEventAction.new()
	
	new_event.action = action
	new_event.pressed = pressed
	
	return new_event

func _ready():
	owner = get_parent()
	pass

func _unhandled_input(event):
	if event is InputEventMouseButton and event.pressed:
		path = owner.get_map().get_node("AStarPathfinder").get_tile_path(
				owner.position,
				owner.get_map().get_local_mouse_position(),
				250,
				owner.possible_moves,
				owner.can_use_portals)

func _process(delta):
	if path.size() > 0:
		var new_direction = -(owner.get_map().vector_to_tile_pos(owner.position) - path[0])
		
		if new_direction == Vector2(0, 0):
			path.pop_front()
		
		direction = new_direction
		destination_changed()
		
		
	
func destination_changed():
	set_walking(direction.x)
	if direction.y < 0:
		jump()

func jump():
	var action = generate_action("jump", true)
	emit_signal("simulate_input", action)

func set_walking(direction: int):
	var action
	if direction == 0:
		_stop_walking()
		return
		
	if direction > 0:
		action = generate_action("move_right", true)
	elif direction < 0:
		action = generate_action("move_left", true)
		
	emit_signal("simulate_input", action)

func _stop_walking():
	var stop_right_action = generate_action("move_right", false)
	var stop_left_action = generate_action("move_left", false)
	
	emit_signal("simulate_input", stop_right_action)
	emit_signal("simulate_input", stop_left_action)
