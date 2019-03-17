extends ProgressBar

export(String) var stat_path

func _ready():
	pass

func _process(delta):
	var stat = owner.subject.get_node("Statistics/"+stat_path)
	value = stat.current/stat.maximal
	pass