extends Node2D

@onready var sprite_2d: AnimatedSprite2D = $Sprite2D
@onready var reset_timer: Timer = $ResetTimer

func _ready() -> void:
	reset_timer.wait_time = 0.2 
	reset_timer.one_shot = true

func _process(delta: float) -> void:
	pass

func _unhandled_input(event: InputEvent) -> void:
	if event.is_action_pressed("dodge_up"):
		sprite_2d.frame = 1
		reset_timer.start()
		
	elif event.is_action_pressed("dodge_right"):
		sprite_2d.frame = 2
		reset_timer.start()
		
	elif event.is_action_pressed("dodge_left"):
		sprite_2d.frame = 3
		reset_timer.start()

func _on_reset_timer_timeout() -> void:
	sprite_2d.frame = 0
