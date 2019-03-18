extends TabContainer

var subject: Node2D

func _ready():
	pass

func init(node: Node2D):
	subject = node
	#current_tab = 0

func _close(tab):
	if get_child(tab).name == "X":
		queue_free()
