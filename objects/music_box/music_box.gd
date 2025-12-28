extends Node2D


@onready var mbusindex: int = AudioServer.get_bus_index("MusicBox")
@onready var music: AudioStreamPlayer2D = $MusicBox_Audio
@onready var button: Button = $Button
@onready var gm: GameManager = GameManager.get_instance()
@onready var gmconfig: DifficultyConfig = GameManager.get_config()
@onready var _current_value: float = gmconfig.musicbox_starting_value
var _is_held: bool = false
var _pitch_error_positive: float


func _process(delta: float) -> void:
	if _is_held:
		if _current_value <= gmconfig.musicbox_max_threshold: 
			_current_value = min(_current_value + delta * gmconfig.musicbox_wind_speed, gmconfig.musicbox_max_threshold)
	else:
		_current_value = max(_current_value - delta * gmconfig.musicbox_unwind_speed, 0.0)

	if _current_value <= 0.0:
		gm.lose()
	elif _current_value <= gmconfig.musicbox_silent_threshold:
		#if _current_value / gmconfig.musicbox_silent_threshold < randf():
			#gm.lose()
		AudioServer.set_bus_volume_linear(mbusindex, 0.0)
	elif _current_value <= gmconfig.musicbox_slowing_threshold:
		var _pitch_error: float = (_current_value - gmconfig.musicbox_slowing_threshold) * 0.4 / (gmconfig.musicbox_slowing_threshold - gmconfig.musicbox_silent_threshold)
		music.pitch_scale = 1.0 + _pitch_error
		AudioServer.set_bus_volume_linear(mbusindex, 1.0 + _pitch_error)
	else:
		_pitch_error_positive = !_pitch_error_positive
		music.pitch_scale = 1.0
		AudioServer.set_bus_volume_linear(mbusindex, 1.0)


func _on_wind_stop() -> void:
	_is_held = false


func _on_wind_start() -> void:
	_is_held = true
