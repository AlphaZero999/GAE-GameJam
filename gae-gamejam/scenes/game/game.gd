extends Node

@onready var conductor: AudioStreamPlayer = $Conductor

@onready var spawn_left: Node2D = %SpawnLeft
@onready var spawn_right: Node2D = %SpawnRight
@onready var spawn_up: Node2D = %SpawnUp
#@onready var spawn_down: Node2D = %SpawnDown

@onready var arrow_left: AnimatedSprite2D = $PlayArea/ArrowLeft
@onready var arrow_right: AnimatedSprite2D = $PlayArea/ArrowRight
@onready var arrow_up: AnimatedSprite2D = $PlayArea/ArrowUp

@onready var pistols: Node2D = $Pistols

@onready var score_label: Label = %ScoreLabel
@onready var combo_label: Label = %ComboLabel



var score = 0
var combo = 0

var max_combo = 0
var great = 0
var good = 0
var okay = 0
var missed = 0

var bpm = 115

var song_position = 0.0
var song_position_in_beats = 0
var last_spawned_beat = 0
var sec_per_beat = 60.0 / bpm

var spawn_1_beat = 0
var spawn_2_beat = 0
var spawn_3_beat = 0
var spawn_4_beat = 0

var spawn_point
var direction

var rand = 0
var note = preload("res://scenes/note/note.tscn")
var instance

var rng = RandomNumberGenerator.new()

func _ready() -> void:
	
	arrow_left.connect("arrow_hit", shoot_pistol)
	arrow_right.connect("arrow_hit", shoot_pistol)
	arrow_up.connect("arrow_hit", shoot_pistol)
	
	conductor.play_with_beats_offset(4)
	#conductor.play_from_beat(36, 4)
	
	ConductorVariables.connect("beat", _on_Conductor_beat)
	ConductorVariables.connect("measure", _on_Conductor_measure)

func shoot_pistol():
	pistols.shoot()

func _process(delta: float) -> void:
	pass

func _on_Conductor_measure(position):
	if position == 1:
		_spawn_notes(spawn_1_beat)
	elif position == 2:
		_spawn_notes(spawn_2_beat)
	elif position == 3:
		_spawn_notes(spawn_3_beat)
	elif position == 4:
		_spawn_notes(spawn_4_beat)


func _on_Conductor_beat(position):
	print(position)
	song_position_in_beats = position
	if song_position_in_beats > 8:
		spawn_1_beat = 1
		spawn_2_beat = 0
		spawn_3_beat = 0
		spawn_4_beat = 0
	if song_position_in_beats > 32:
		spawn_1_beat = 1
		spawn_2_beat = 0
		spawn_3_beat = 1
		spawn_4_beat = 0
	if song_position_in_beats > 48:
		spawn_1_beat = 1
		spawn_2_beat = 1
		spawn_3_beat = 1
		spawn_4_beat = 0
	if song_position_in_beats > 52:
		spawn_1_beat = 1
		spawn_2_beat = 0
		spawn_3_beat = 1
		spawn_4_beat = 0
	if song_position_in_beats > 56:
		spawn_1_beat = 1
		spawn_2_beat = 1
		spawn_3_beat = 1
		spawn_4_beat = 0
	if song_position_in_beats > 60:
		spawn_1_beat = 1
		spawn_2_beat = 0
		spawn_3_beat = 1
		spawn_4_beat = 0
	if song_position_in_beats > 66:
		spawn_1_beat = 1
		spawn_2_beat = 1
		spawn_3_beat = 1
		spawn_4_beat = 1
	if song_position_in_beats > 82:
		spawn_1_beat = 1
		spawn_2_beat = 0
		spawn_3_beat = 1
		spawn_4_beat = 1
	if song_position_in_beats > 88:
		spawn_1_beat = 0
		spawn_2_beat = 1
		spawn_3_beat = 0
		spawn_4_beat = 1
	if song_position_in_beats > 96:
		spawn_1_beat = 1
		spawn_2_beat = 1
		spawn_3_beat = 1
		spawn_4_beat = 1
	if song_position_in_beats > 109:
		spawn_1_beat = 0
		spawn_2_beat = 0
		spawn_3_beat = 0
		spawn_4_beat = 0
	if song_position_in_beats > 114:
		ConductorVariables.set_score(score)
		ConductorVariables.combo = max_combo
		ConductorVariables.great = great
		ConductorVariables.good = good
		ConductorVariables.okay = okay
		ConductorVariables.missed = missed
		if ConductorVariables.highscore < score:
			ConductorVariables.highscore = score
		if get_tree().change_scene_to_file("res://scenes/end/end.tscn") != OK:
			print ("Error changing scene to End")


func _spawn_notes(to_spawn):
	if to_spawn > 0:
		direction = rng.randi_range(0, 2)
		instance = note.instantiate()
		init_note(direction)
	if to_spawn > 1:
		while rand == direction:
			rand = rng.randi_range(0, 2)
		direction = rand
		instance = note.instantiate()
		init_note(direction)
		

func init_note(direction: int):
	match direction:
			0:
				instance.initialize(Vector2(-1, 0)) # Left
				add_child(instance)
				instance.position = spawn_left.position
			1:
				instance.initialize(Vector2(1, 0)) # Right
				add_child(instance)
				instance.position = spawn_right.position
			2:
				instance.initialize(Vector2(0, -1)) # Up
				add_child(instance)
				instance.position = spawn_up.position
			#3:
				#instance.initialize(Vector2(0, 1)) # Down
				#add_child(instance)
				#instance.position = spawn_down.position

func increment_score(by):
	if by > 0:
		combo += 1
	else:
		combo = 0
	
	if by == 3:
		great += 1
	elif by == 2:
		good += 1
	elif by == 1:
		okay += 1
	else:
		missed += 1
	
	
	score += by * combo
	score_label.text = str(score)
	if combo > 0:
		combo_label.text = "X " + str(combo)
		if combo > max_combo:
			max_combo = combo
	else:
		combo_label.text = "X 0"


func reset_combo():
	combo = 0
	combo_label.text = "X 0"
