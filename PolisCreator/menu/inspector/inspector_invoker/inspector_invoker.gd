extends Control

func _ready():
	for node in get_tree().get_nodes_in_group("inspector_subjects"):
		node.get_node("InspectorTrigger").connect("invoke_inspector", self, "_on_invoke")
		
func _on_invoke(node, event):
	if event is InputEventMouseButton and event.pressed:
		print(node.name)