extends Node


signal simulate_input(Event)

func _generate_action(action: String, pressed: bool) -> InputEventAction:
	var new_event = InputEventAction.new()
	
	new_event.action = action
	new_event.pressed = pressed
	
	return new_event

func _stop_walking():
	var stop_right_action = _generate_action("move_right", false)
	var stop_left_action = _generate_action("move_left", false)
	
	emit_signal("simulate_input", stop_right_action)
	emit_signal("simulate_input", stop_left_action)

func set_walking(direction: int):
	var action
	if direction == 0:
		_stop_walking()
		return
		
	if direction > 0:
		action = _generate_action("move_right", true)
	elif direction < 0:
		action = _generate_action("move_left", true)
		
	emit_signal("simulate_input", action)
	
func start_jumping():
	var jump = _generate_action("jump", true)
	emit_signal("simulate_input", jump)

func stop_jumping():
	var jump = _generate_action("jump", false)
	emit_signal("simulate_input", jump)
	
func single_button_press(action_name: String):
	var action = _generate_action(action_name, true)
	emit_signal("simulate_input", action)
	
	#Stop function execution to the next frame
	yield(get_tree(), "idle_frame")
	
	action = _generate_action(action_name, false)
	emit_signal("simulate_input", action)

	connect("direction_changed", self, "_direction_changed")