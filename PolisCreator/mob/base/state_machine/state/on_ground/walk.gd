extends "on_ground.gd"

export(int) var walk_speed = 400

func _ready():
	pass

func enter():
	if !(owner.event_map.has("move_left") or owner.event_map.has("move_right")):
		emit_signal("finished", "Idle")
	owner.get_node("AnimationPlayer").play("walk")

func update(delta):
	.update(delta)
	
	var move_right = owner.event_map.find("move_right")
	var move_left = owner.event_map.find("move_left")
	
	if move_left > move_right:
		owner.motion.x = -walk_speed
	elif move_left < move_right:
		owner.motion.x = walk_speed
	else:
		emit_signal("finished", "Idle")