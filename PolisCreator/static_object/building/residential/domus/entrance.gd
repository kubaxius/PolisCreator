extends StaticBody2D

func _ready():
	shape_owner_set_disabled(0, false)

	
func use(node):
	owner.use(node)