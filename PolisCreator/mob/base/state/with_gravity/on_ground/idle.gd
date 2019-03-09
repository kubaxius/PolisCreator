extends "on_ground.gd"

func _ready():
	pass
	
func update(delta):
	owner.motion.x = lerp(owner.motion.x, 0, owner.on_ground_friction)
	if owner.movement_direction:
		emit_signal("finished", "Move")
	.update(delta)