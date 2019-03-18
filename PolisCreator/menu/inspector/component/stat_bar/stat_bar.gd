extends ProgressBar

export(String) var stat_path
export(bool) var inverted
export(String) var stat_name


var stat: Node

func _ready():
	stat = owner.subject.get_node("Statistics/"+stat_path)
	$StatName.text = stat_name
	pass

func _process(delta):
	if not inverted:
		value = stat.current/stat.maximal
	else:
		value = 1 - stat.current/stat.maximal
	pass