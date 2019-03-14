extends StaticBody2D

export var capacity := 2

var inhabitants := []

func _ready():
	pass

func use(node):
	print(node.name)
	$AnimationPlayer.play("show_inside")