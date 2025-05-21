extends Node

@onready var total_score: Label = %TotalScore
@onready var combo: Label = %Combo
@onready var perfect: Label = %Perfect
@onready var good: Label = %Good
@onready var okay: Label = %Okay
@onready var misses: Label = %Misses

func _ready() -> void:
	total_score.text = "SCORE: " + str(ConductorVariables.score)
	combo.text = "COMBO: " + str(ConductorVariables.combo)
	perfect.text = "PERFECT: " + str(ConductorVariables.great)
	good.text = "GOOD: " + str(ConductorVariables.good)
	okay.text = "OKAY: " + str(ConductorVariables.okay)
	misses.text = "MISSES: " + str(ConductorVariables.missed)

func _on_retry_button_pressed() -> void:
	get_tree().change_scene_to_file("res://scenes/game/game.tscn")


func _on_main_menu_button_pressed() -> void:
	get_tree().change_scene_to_file("res://scenes/main.tscn")
