extends Area2D

var dist_to_target = 120
var direction: Vector2

var speed = 1
var hit = false

var destroy_threshold = 200


func _ready():
	pass


func _physics_process(delta):
	if !hit:
		position -= speed * dist_to_target * delta * direction
		if position.length() > destroy_threshold:
			queue_free()
			get_parent().reset_combo()
	else:
		$Node2D.position += speed * dist_to_target * delta * direction


func initialize(_direction: Vector2):
	direction = _direction
	if direction == Vector2(-1, 0): # Left
		$AnimatedSprite.frame = 0
	elif direction == Vector2(1, 0): # Right
		$AnimatedSprite.frame = 1
	elif direction == Vector2(0, -1): # Up
		$AnimatedSprite.frame = 2
	elif direction == Vector2(0, 1): # Down
		$AnimatedSprite.frame = 3
	else:
		printerr("Invalid note initialization: " + str(_direction))
		return
	#dist_to_target = _spawn_point
	#speed = dist_to_target


func destroy(score):
	$CPUParticles2D.emitting = true
	$AnimatedSprite.visible = false
	$Timer.start()
	hit = true
	if score == 3:
		$Node2D/Label.text = "PERFECT"
		$Node2D/Label.modulate = Color("f6d6bd")
	elif score == 2:
		$Node2D/Label.text = "GOOD"
		$Node2D/Label.modulate = Color("c3a38a")
	elif score == 1:
		$Node2D/Label.text = "OKAY"
		$Node2D/Label.modulate = Color("997577")
	elif score == 0:
		$Node2D/Label.text = "MISS"
		$Node2D/Label.modulate = Color("e32619")

func _on_timer_timeout() -> void:
	queue_free()
