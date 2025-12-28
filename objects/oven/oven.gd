class_name Oven
extends Node2D


'''
SFX todo:
	- Ambient fire cracking (depending on amount of fuel)

Animations / images:
	- Glow (depending on amount of fuel)
	- Oven itself
	- Fire inside
'''

const NO_LOG_HINT = "try to find a log to throw into it"
const HAS_LOG_HINT = "you can throw log into it"

@onready var _oven_hint: Label = $OvenHint
@onready var gm: GameManager = GameManager.get_instance()
@onready var gmconfig: DifficultyConfig = GameManager.get_config()
@onready var heat: float = gmconfig.oven_starting_heat
@onready var _heat_per_log: float = gmconfig.oven_heating_per_log
@onready var _temp_diff: float = -gmconfig.oven_cooling_speed
var has_log: bool = false
var _heating: float

@onready var _button: Button = $ThrowLogsButton
@onready var _sprite: AnimatedSprite2D = $Sprite2D
@onready var _particles: CPUParticles2D = $CPUParticles2D


## This formula arose from Physics movement equations
## [DO NOT TOUCH]
func _calculate_heat_per_log_per_sec():
	_heating = gmconfig.oven_cooling_speed * sqrt(2 * _heat_per_log / gmconfig.oven_cooling_speed)


func _ready() -> void:
	_calculate_heat_per_log_per_sec()


func _process(delta: float) -> void:
	if has_log:
		_oven_hint.text = HAS_LOG_HINT
	else:
		_oven_hint.text = NO_LOG_HINT

	_sprite.play("hovered" if _button.is_hovered() else "idle")

	# This calculates how long in hours can player last considering he has 10 logs
	# print((gmconfig.oven_starting_heat + gmconfig.oven_heating_per_log * 10) / gmconfig.oven_cooling_speed / gmconfig.night_hour_length)

	# This updates heating on config change
	if _heat_per_log != gmconfig.oven_heating_per_log:
		_heat_per_log = gmconfig.oven_heating_per_log
		_calculate_heat_per_log_per_sec()

	heat = clampf(heat + _temp_diff * delta, 0.0, gmconfig.oven_max_heat)
	if heat <= 0:
		gm.lose()
	_particles.emitting = heat > gmconfig.oven_max_heat / 2
	if _temp_diff > -gmconfig.oven_cooling_speed:
		_temp_diff = clampf(_temp_diff - gmconfig.oven_cooling_speed * delta, -gmconfig.oven_cooling_speed, _heating)


func _on_oven_pressed() -> void:
	if has_log:
		has_log = false
		_temp_diff = _heating
