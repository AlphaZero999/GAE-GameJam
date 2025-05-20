extends Node2D

var pistol_index = 0

@onready var pistol_left: AnimatedSprite2D = %PistolLeft
@onready var pistol_right: AnimatedSprite2D = %PistolRight


func shoot():
	pistol_index = 1 - pistol_index
	
	if pistol_index == 0:
		pistol_left.get_child(0).play("shoot")
	else:
		pistol_right.get_child(0).play("shoot")
