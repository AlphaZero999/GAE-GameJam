extends AudioStreamPlayer

@onready var start_timer: Timer = $StartTimer


@export var bpm = 100
@export var measures = 4

var song_position = 0.0
var song_position_in_beats = 1
var sec_per_beat = 60 / bpm
var last_reported_beat = 0
var beats_before_start = 0
var measure = 1

var closest = 0
var time_off_beat = 0.0

func _ready() -> void:
	sec_per_beat = 60.0 / bpm

func _physics_process(delta: float) -> void:
	if playing:
		song_position = get_playback_position() + AudioServer.get_time_since_last_mix()
		song_position -= AudioServer.get_output_latency()
		song_position_in_beats = int(floor(song_position / sec_per_beat)) + beats_before_start
		_report_beat()
		

func _report_beat():
	if last_reported_beat < song_position_in_beats:
		if measure > measures:
			measure = 1
		ConductorVariables.beat.emit(song_position_in_beats)
		ConductorVariables.measure.emit(measure)
		last_reported_beat = song_position_in_beats
		measure += 1

# Play beats before the song is starting
func play_with_beats_offset(num):
	beats_before_start = num
	start_timer.wait_time = sec_per_beat
	start_timer.start()

# Play the beat on offset
func play_from_beat(beat, offset):
	play()
	seek(beat * sec_per_beat)
	beats_before_start = offset
	
	measure = beat % measures  


func _on_start_timer_timeout() -> void:
	song_position_in_beats += 1
	if song_position_in_beats < beats_before_start - 1:
		start_timer.start()
	elif song_position_in_beats == beats_before_start - 1:
		start_timer.wait_time = start_timer.wait_time - (AudioServer.get_time_to_next_mix() + AudioServer.get_output_latency())
		start_timer.start()
	else:
		play()
		start_timer.stop()
	_report_beat()
