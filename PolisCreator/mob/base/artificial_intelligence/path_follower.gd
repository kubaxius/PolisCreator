extends Node


var path = []
var direction := Vector2(0, 0) setget _set_direction
var tpos = Vector2()

signal direction_changed
signal reached_goal

func _ready():
	connect("direction_changed", self, "_direction_changed")
	pass

func _unhandled_input(event):
	#_debug_pathfinding(event)
	pass

func _process(delta):
	tpos = Tool.vector_to_tile_pos(owner.position)
	_follow_direction()

func _follow_direction():
	if path.size() == 0 and direction != Vector2(0, 0):
		self.direction = Vector2(0, 0)
	
	if path.size() != 0:
		if tpos == path[0]:
			#Use teleport if possible and if it is on your path
			if PathFinder.teleports_links.has(path[0]):
				if path.size() != 1 and PathFinder.teleports_links[path[0]] == path[1]:
					$"../InputSimulator".single_button_press("use")
			if path.size() == 1:
				emit_signal("reached_goal")
			path.pop_front()
			
		elif direction != (path[0] - tpos):
			self.direction = path[0] - tpos

func _set_direction(value):
	direction = value
	emit_signal("direction_changed")

func _direction_changed():
	$"../InputSimulator".set_walking(direction.x)
	if direction.y < 0:
		$"../InputSimulator".start_jumping()
	else:
		$"../InputSimulator".stop_jumping()
	pass

func _debug_pathfinding(event):
	if event is InputEventMouseButton and event.pressed:
		$"../DebugLine".points = []
		set_new_direction(Tool.get_listed_scene("MAP").get_local_mouse_position())
		for tpos in path:
			$"../DebugLine".add_point((tpos * 128) + Vector2(64, 64))
			
func set_new_direction(pos: Vector2):
	path = PathFinder.get_simple_path(owner, pos)
