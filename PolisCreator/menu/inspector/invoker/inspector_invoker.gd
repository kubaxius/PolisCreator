extends Node

var citizen_inspector = preload("res://menu/inspector/citizen/CitizenInspector.tscn")

func _ready():
	get_tree().connect("node_added", self, "_on_node_added")

func _on_invoke(node, event):
	if event is InputEventMouseButton and event.pressed:
		show_inspector(node)

func show_inspector(node: Node2D):
	for old_inspector in get_tree().get_nodes_in_group("inspectors"):
		old_inspector.queue_free()

	if node.is_in_group("citizens"):
		var inspector = citizen_inspector.instance()
		inspector.init(node)
		$"..".add_child(inspector)


"""
This function is called everytime node is added to tree.
It connects all subjects to function _on_invoke
"""
func _on_node_added(node):
	for node in get_tree().get_nodes_in_group("inspector_subjects"):
		node.get_node("InspectorTrigger").connect("invoke_inspector", self, "_on_invoke")