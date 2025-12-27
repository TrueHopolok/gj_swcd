extends Node2D

@onready var music: AudioStreamPlayer2D = $AudioStreamPlayer2D
@onready var button: Button = $Button

@onready var config : DifficultyConfig = GameManager.get_instance().config

@onready var SLOW_WINDOW: float = config.SLOW_WINDOW
@onready var SILENT_AT: float = config.SILENT_AT   
@onready var MAX_VALUE: float = config.MAX_VALUE 
@onready var WINDUP_MULTIPLIER = config.WINDUP_MULTIPLIER
@onready var timer_value: float = config.DEFAULT_TIMER_VALUE
const MIN_SPEED: float = 0.05
const MIN_VOLUME: float = 0.25      
var is_held: bool = false
func _process(delta: float) -> void:
	print(timer_value)
	if is_held and timer_value <= MAX_VALUE:
		timer_value += delta * 3.0
		
	var box: float = float(timer_value)
	box = maxf(box - delta, SILENT_AT)
	timer_value = box

	if box <= SILENT_AT:
		set_music_speed(MIN_SPEED)
		music.volume_linear = 0.0
	elif box <= SLOW_WINDOW:
		var u: float = clampf((box - SILENT_AT) / (SLOW_WINDOW - SILENT_AT), 0.0, 1.0)
		u = u * u * (3.0 - 2.0 * u)
		var speed: float = lerpf(MIN_SPEED, 1.0, u)
		var vol: float = lerpf(MIN_VOLUME, 1.0, u)
		set_music_speed(speed)
		music.volume_linear = vol
	else:
		set_music_speed(1.0)
		music.volume_linear = 1.0


func set_music_speed(speed: float) -> void:
	music.pitch_scale = clampf(speed, MIN_SPEED, 4.0)

func _on_button_button_up() -> void:
	is_held = false

func _on_button_button_down() -> void:
	is_held = true
