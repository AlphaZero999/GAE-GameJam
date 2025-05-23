extends Node

@onready var highscore_label: Label = $HighscoreLabel

func _ready() -> void:
	highscore_label.text = "Highscore: " + str(ConductorVariables.highscore)

func _on_play_button_pressed() -> void:
	get_tree().change_scene_to_file("res://scenes/game/game.tscn")


func _on_options_button_pressed() -> void:
	get_tree().change_scene_to_file("res://scenes/options_menu/options_menu.tscn")


func _on_quit_button_pressed() -> void:
	get_tree().quit()
