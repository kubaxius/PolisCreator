extends "res://mob/base/artificial_intelligence/artificial_intelligence.gd"

func _ready():
	possible_todos = [
		"go_home",
		"go_to_work"
	]
	connect("goal_set", self, "_complete_the_goal")
	connect("goal_completed", self, "_goal_completed")
	todo_list.append("go_home")

func _process(delta):
	if current_goal.empty() and todo_list.size() != 0:
		current_goal = todo_list.pop_front()
		emit_signal("goal_set")

func _complete_the_goal():
	match current_goal:
		"go_home":
			_go_home()
			yield($PathFollower, "reached_goal")

func _go_home():
	if is_instance_valid(owner.home):
		$PathFollower.set_new_direction(owner.home.get_node("Entrance/Entrance").global_position)
		yield($PathFollower, "reached_goal")
		$InputSimulator.single_button_press("use")
		emit_signal("goal_completed")
		
func _goal_completed():
	current_goal = ""