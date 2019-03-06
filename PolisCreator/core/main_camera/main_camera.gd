extends Camera2D

var last_mouse_pos = 0

func _ready():
	pass
	
func _process(delta):
	change_pos()
	pass
	
func change_pos():
	var current_mouse_pos = get_global_mouse_position()
	
	if Input.is_action_pressed("map_drag") and Input.is_action_pressed("mouse_down"):
		
		var drag_speed = ProjectSettings.get_setting("others/camera/drag_speed")
		var diff = (last_mouse_pos - current_mouse_pos) * drag_speed
		
		translate(diff)
	
	last_mouse_pos = current_mouse_pos
	
func zoom(val):
	var min_zoom = ProjectSettings.get_setting("others/camera/zoom/min")
	var max_zoom = ProjectSettings.get_setting("others/camera/zoom/max")
	var scale = (min_zoom * val) + (max_zoom * (1 - val))
	zoom = Vector2(scale, scale)