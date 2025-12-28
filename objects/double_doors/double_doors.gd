extends Node2D


'''
SFX todo:
	- Added for the night
	- Spawn on left/right
	- Close left/right door
	- Bonk that defended
	- DEATH?

Animations / images todo:
	- Open/close door
	- DEATH?
'''

@onready var steps: AudioStreamPlayer2D = $Steps
@onready var gm: GameManager = GameManager.get_instance()
@onready var gmconfig: DifficultyConfig = GameManager.get_config()
@onready var _attack_timer: Timer 	= $AttackTimer
@onready var _rest_timer: Timer 	= $RestTimer
@onready var _sprite: Sprite2D = $Sprite2D
var _attacking_left: bool = true
var _defending_left: bool = true


func _ready() -> void:
	if gmconfig.doors_start_hour == 0:
		_on_start_end(0)
	else:
		get_tree().get_first_node_in_group("NightTimer").hour_passed.connect(_on_start_end)


func _on_start_end(hour: int) -> void:
	if hour == gmconfig.doors_start_hour:
		_rest_timer.start(randf_range(gmconfig.doors_min_rest_time, gmconfig.doors_max_rest_time))


func _on_rest_end() -> void:
	_attacking_left = randi_range(0, 1) == 0
	_attack_timer.start(gmconfig.doors_attack_time)
	print("DOUBLE_DOORS: ", "left" if _attacking_left else "right")
	if _attacking_left:
		var bus_idx := AudioServer.get_bus_index("SFX_PAN_MAN")
		var fx := AudioServer.get_bus_effect(bus_idx, 0)
		fx.pan = -1
	else:
		var bus_idx := AudioServer.get_bus_index("SFX_PAN_MAN")
		var fx := AudioServer.get_bus_effect(bus_idx, 0)
		fx.pan = 1
	steps.play(0)


func _on_attack_end() -> void:
	if (_attacking_left && _defending_left) || (!_attacking_left && !_defending_left):
		_rest_timer.start(randf_range(gmconfig.doors_min_rest_time, gmconfig.doors_max_rest_time))
	else:
		gm.lose()
	steps.stop()


func _on_left_door_pressed() -> void:
	_defending_left = true
	_sprite.flip_h = true


func _on_right_door_pressed() -> void:
	_defending_left = false
	_sprite.flip_h = false
