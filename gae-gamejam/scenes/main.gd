extends Node


func _on_play_button_pressed() -> void:
	get_tree().change_scene_to_file("res://scenes/game/game.tscn")


func _on_options_button_pressed() -> void:
	pass # Replace with function body.
	#TODO OptionsMenu


func _on_quit_button_pressed() -> void:
	get_tree().quit()
