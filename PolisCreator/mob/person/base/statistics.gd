extends Node

var needs = {
	"food": 0,
	"sleep": 0,
	"entertainment": 0
}

var need_increase_multiplier = {
	"food": 0.01,
	"sleep": 0.01,
	"entertainment": 0.01
}

var character = {
	"introvertism": 0
}

var willpower = 100

var home: Node2D
var workplace: Node2D

func _ready():
	pass

func _process(delta):
	increase_needs(delta)

func increase_needs(delta):
	for key in needs.keys():
		if needs[key] != 1:
			needs[key] += need_increase_multiplier[key] * delta
			if needs[key] > 1:
				needs[key] = 1

func find_home():
	pass