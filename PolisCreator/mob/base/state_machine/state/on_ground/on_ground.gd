extends "../state.gd"

var on_ground_friction := 0.2

func _ready():
	pass
	
func update(delta):
	.update(delta)
	if owner.event_map.has("jump") or owner.event_map.has("jump"):
		emit_signal("finished", "Jump")