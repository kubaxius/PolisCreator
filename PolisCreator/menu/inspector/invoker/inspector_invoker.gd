extends Node

var citizen_inspector = preload("res://menu/inspector/citizen/CitizenInspector.tscn")

func _ready():
	for node in get_tree().get_nodes_in_group("inspector_subjects"):
		node.get_node("InspectorTrigger").connect("invoke_inspector", self, "_on_invoke")
		
func _on_invoke(node, event):
	if event is InputEventMouseButton and event.pressed:
		show_inspector(node)
		
func show_inspector(node: Node2D):
	if node.is_in_group("citizens"):
		var inspector = citizen_inspector.instance()
		inspector.init(node)
		owner.add_child(inspector)