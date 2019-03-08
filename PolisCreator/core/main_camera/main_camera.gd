extends Camera2D

func _ready():
	pass
	
func _unhandled_input(event: InputEvent):
	change_pos(event)
	pass
	
func change_pos(event: InputEvent):
	var current_mouse_pos = get_global_mouse_position()
	
	#is button responsible for map dragging pressed
	if Input.is_action_pressed("map_drag") and (event is InputEventMouseMotion):
		
		#get camera drag speed from project settings
		var drag_speed = ProjectSettings.get_setting("others/camera/drag_speed")
		
		#calculate difference in position and move camera to it
		var diff = -event.relative * drag_speed
		translate(diff)
	
func zoom(val):
	var min_zoom = ProjectSettings.get_setting("others/camera/zoom/min")
	var max_zoom = ProjectSettings.get_setting("others/camera/zoom/max")
	var scale = (min_zoom * val) + (max_zoom * (1 - val))
	zoom = Vector2(scale, scale)