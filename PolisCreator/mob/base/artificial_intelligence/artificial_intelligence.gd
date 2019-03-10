extends Node

var path = []
var teleports_on_path = []
var direction := Vector2(0, 0) setget _set_direction
var tpos = Vector2()

var jump_timer

signal simulate_input(Event)
signal direction_changed

func generate_action(action: String, pressed: bool) -> InputEventAction:
	var new_event = InputEventAction.new()
	
	new_event.action = action
	new_event.pressed = pressed
	
	return new_event

func single_button_press(action_name: String):
	var action = generate_action(action_name, true)
	emit_signal("simulate_input", action)
	
	#Stop function execution to the next frame
	yield(get_tree(), "idle_frame")
	
	action = generate_action(action_name, false)
	emit_signal("simulate_input", action)

func _ready():
	connect("direction_changed", self, "_direction_changed")
	pass

func _unhandled_input(event):
	#debug_pathfinding(event)
	pass

func _process(delta):
	tpos = Tool.vector_to_tile_pos(owner.position)
	follow_direction()

func follow_direction():
	if path.size() == 0 and direction != Vector2(0, 0):
		self.direction = Vector2(0, 0)
	
	if path.size() != 0:
		if tpos == path[0]:
			if teleports_on_path.has(path[0]):
				single_button_press("use")
			path.pop_front()
			
		elif direction != (path[0] - tpos):
			self.direction = path[0] - tpos

func start_jumping():
	var jump = generate_action("jump", true)
	emit_signal("simulate_input", jump)

func stop_jumping():
	var jump = generate_action("jump", false)
	emit_signal("simulate_input", jump)

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

func _set_direction(value):
	direction = value
	emit_signal("direction_changed")

func _direction_changed():
	set_walking(direction.x)
	if direction.y < 0:
		start_jumping()
	else:
		stop_jumping()
	pass
	
func debug_pathfinding(event):
	if event is InputEventMouseButton and event.pressed:
		path = $AStarPathfinder.get_tile_path(
				owner.position,
				Tool.get_main_scene("MAP").get_local_mouse_position(),
				250,
				[],
				owner.can_use_portals)
		teleports_on_path = $AStarPathfinder.get_teleports(path)
		path = $AStarPathfinder.simplify_path(path)