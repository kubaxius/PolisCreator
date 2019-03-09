extends Node

signal state_changed(current_state)

export(NodePath) var START_STATE

var states_stack = []
var current_state = null
var _active = false setget set_active


func _ready():
	for child in get_children():
		child.connect("finished", self, "_change_state")
		child.owner = get_parent()
	get_parent().get_node("AI").connect("simulate_input", self, "_AI_input")
	initialize(START_STATE)

func initialize(start_state):
	set_active(true)
	states_stack.push_front(get_node(start_state))
	current_state = states_stack[0]
	current_state.enter()
	
func set_active(value):
	_active = value
	set_physics_process(value)
	if not _active:
		current_state = null
		
func _AI_input(event):
	if owner.movable_by_AI:
		current_state.handle_input(event)

func _unhandled_input(event):
	if owner.movable_by_player:
		current_state.handle_input(event)

func _physics_process(delta):
	current_state.update(delta)
	
func _change_state(state_name):
	if not _active:
		return
	current_state.exit()
	
	if state_name == "previous":
		states_stack.pop_front()
	else:
		var state_scene = get_node(state_name)
		if state_scene.pushdown:
			states_stack.push_front(get_node(state_name))
		else:
			states_stack[0] = get_node(state_name)
	
	current_state = states_stack[0]
	emit_signal("state_changed", current_state)
	
	if state_name != "previous":
		current_state.enter()