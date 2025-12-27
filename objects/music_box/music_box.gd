extends Node2D


@onready var music: AudioStreamPlayer2D = $AudioStreamPlayer2D
@onready var button: Button = $Button
@onready var gm: GameManager = GameManager.get_instance()
@onready var _current_value: float = gm.config.musicbox_starting_value
var _is_held: bool = false
var _pitch_error_positive: float

func _process(delta: float) -> void:
	if _is_held:
		if _current_value <= gm.config.musicbox_max_threshold: 
			_current_value = min(_current_value + delta * gm.config.musicbox_wind_speed, gm.config.musicbox_max_threshold)
	else:
		_current_value = max(_current_value - delta * gm.config.musicbox_unwind_speed, 0.0)

	if _current_value <= 0.0:
		gm.lose()
	elif _current_value <= gm.config.musicbox_silent_threshold:
		music.volume_linear = 0.0
		#if _current_value / gm.config.musicbox_silent_threshold < randf():
			#gm.lose()
	elif _current_value <= gm.config.musicbox_slowing_threshold:
		var _pitch_error: float = 1.0 if _pitch_error_positive else -1.0
		_pitch_error = (_current_value - gm.config.musicbox_slowing_threshold) * (-0.4 * _pitch_error) / (gm.config.musicbox_slowing_threshold - gm.config.musicbox_silent_threshold)
		music.pitch_scale = 1.0 + _pitch_error
		music.volume_linear = 1.0
	else:
		_pitch_error_positive = !_pitch_error_positive
		music.pitch_scale = 1.0
		music.volume_linear = 1.0


func _on_wind_stop() -> void:
	_is_held = false


func _on_wind_start() -> void:
	_is_held = true
