extends Node

signal beat
signal measure

var score = 0
var combo = 0
var great = 0
var good = 0
var okay = 0
var missed = 0

func set_score(_score):
	score = _score
