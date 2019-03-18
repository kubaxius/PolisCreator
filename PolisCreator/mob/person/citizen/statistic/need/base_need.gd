extends Node

export(float, 0.1) var base_growth = 0.001

export(float, 1) var current = 0


export(float, 0, 1, 0.05) var physical_condition_weight = 0
export(float, 0, 1, 0.05) var psychical_condition_weight = 0
export(float, 0, 1, 0.05) var mental_condition_weight = 0


var maximal: float setget , _get_maximal

func _ready():
	pass

func _process(delta):
	current += base_growth*delta

func _get_maximal() -> float:
	
	var physical = $"../../Condition/Physical"
	var psychical = $"../../Condition/Psychical"
	var mental = $"../../Condition/Mental"
	
	var c_physical = lerp(1, physical.current, physical_condition_weight)
	var c_psychical = lerp(1, psychical.current, psychical_condition_weight)
	var c_mental = lerp(1, mental.current, mental_condition_weight)
	
	return c_physical * c_psychical * c_mental