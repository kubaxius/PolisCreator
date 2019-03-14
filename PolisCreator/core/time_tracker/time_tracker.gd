extends Node2D

var current_time: float = 0
var current_day_time: float = 0
var current_day_part: String = "afternoon"
var day_parts: Dictionary
var day_length: int

signal day_part_changed(day_time)

func _ready():
	Engine.time_scale = ProjectSettings.get_setting("others/environment/time/scale")
	day_length = ProjectSettings.get_setting("others/environment/time/day_length")
	day_parts = ProjectSettings.get_setting("others/environment/time/day_parts")
	pass

func time_pass(delta):
	current_time += delta
	#var to help create current day time as a float
	var temp = int(floor(current_time))
	current_day_time = (temp % day_length) + (current_time - temp)

func switch_day_part(current_day_time: float):
	var last_difference = 1
	var new_difference = 0
	for day_part in day_parts:
		
		new_difference = (day_length * day_parts[day_part].start) - current_day_time
		
		if new_difference >= 0 and new_difference < last_difference and day_part != current_day_part:
			current_day_part = day_part
			get_child(0).play(current_day_part+"_start")
			emit_signal("day_part_changed", current_day_part)
			

func _process(delta):
	time_pass(delta)
	switch_day_part(current_day_time)
	