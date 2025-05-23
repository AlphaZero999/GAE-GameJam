extends Node

@onready var h_slider: HSlider = $MarginContainer/VBoxContainer/VBoxContainer/HSlider

func _ready() -> void:
	h_slider.value = Settings.music_value

func _on_button_pressed() -> void:
	get_tree().change_scene_to_file("res://scenes/main.tscn")


func _on_h_slider_value_changed(value: float) -> void:
	Settings.music_value = value
	var bus_index = AudioServer.get_bus_index("Master")

	if value == 0.0:
		AudioServer.set_bus_mute(bus_index, true)
	else:
		AudioServer.set_bus_mute(bus_index, false)
		var db = linear_to_db(value)
		AudioServer.set_bus_volume_db(bus_index, db)
