extends AnimatedSprite2D

@onready var push_timer: Timer = $PushTimer

signal arrow_hit

## dodge_left, dodge_right, dodge_up, dodge_down
@export var input = ""

var perfect = false
var good = false
var okay = false
var missed = false
var current_note = null

func _process(delta: float) -> void:
	pass


func _unhandled_input(event: InputEvent) -> void:
	if event.is_action(input):
		if event.is_action_pressed(input, false):
			if current_note != null:
				if perfect:
					get_parent().get_parent().increment_score(3)
					current_note.destroy(3)
				elif good:
					get_parent().get_parent().increment_score(2)
					current_note.destroy(2)
				elif okay:
					get_parent().get_parent().increment_score(1)
					current_note.destroy(1)
				_reset()
			else:
				#pass
				get_parent().get_parent().increment_score(0) #To reset combo
				#current_note.destroy(0)
		if event.is_action_pressed(input):
			frame = 1
		elif event.is_action_released(input):
			push_timer.start()


func _on_perfect_area_area_entered(area: Area2D) -> void:
	if area.is_in_group("note"):
		arrow_hit.emit()
		perfect = true
		#print("Hit Perfect")

func _on_perfect_area_area_exited(area: Area2D) -> void:
	if area.is_in_group("note"):
		perfect = false

func _on_good_area_area_entered(area: Area2D) -> void:
	if area.is_in_group("note"):
		good = true
		#print("Hit Good")

func _on_good_area_area_exited(area: Area2D) -> void:
	if area.is_in_group("note"):
		good = false

func _on_okay_area_area_entered(area: Area2D) -> void:
	if area.is_in_group("note"):
		okay = true
		current_note = area
		#print("Hit okay")

func _on_okay_area_area_exited(area: Area2D) -> void:
	if area.is_in_group("note"):
		okay = false
		current_note = null


func _on_miss_area_area_entered(area: Area2D) -> void:
	if area.is_in_group("note"):
		get_parent().get_parent().increment_score(0) #To reset combo
		area.destroy(0)
		


func _reset():
	current_note = null
	perfect = false
	good = false
	okay = false
	missed = false

func _on_push_timer_timeout() -> void:
	frame = 0
