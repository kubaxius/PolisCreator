extends StaticBody2D

export var capacity := 2

var inhabitants := []

func _ready():
	pass

func use(node):
	$AnimationPlayer.play("show_inside")