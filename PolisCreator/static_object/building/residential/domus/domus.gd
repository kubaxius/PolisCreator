extends StaticBody2D

func _ready():
	pass

func use(node):
	print(node.name)
	$AnimationPlayer.play("show_inside")
	