extends "on_ground.gd"

func _ready():
	pass
	
func enter():
	owner.get_node("AnimationPlayer").play("idle")
	
func update(delta):
	.update(delta)
	owner.motion.x = lerp(owner.motion.x, 0, on_ground_friction)
	if owner.event_map.has("move_left") or owner.event_map.has("move_right"):
		emit_signal("finished", "Walk")