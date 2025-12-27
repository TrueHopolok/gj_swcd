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


@onready var gm: GameManager = GameManager.get_instance()
@onready var _attack_timer: Timer 	= $AttackTimer
@onready var _rest_timer: Timer 	= $RestTimer
var _attacking_left: bool = true
var _defending_left: bool = true


func _ready() -> void:
	$StartTimer.start(gm.config.doors_start_time)


func _on_start_end() -> void:
	_rest_timer.start(randf_range(gm.config.doors_min_rest_time, gm.config.doors_max_rest_time))


func _on_rest_end() -> void:
	_attacking_left = randi_range(0, 1) == 0
	_attack_timer.start(gm.config.doors_attack_time)
	print("DOUBLE_DOORS: ", "left" if _attacking_left else "right")


func _on_attack_end() -> void:
	if (_attacking_left && _defending_left) || (!_attacking_left && !_defending_left):
		_rest_timer.start(randf_range(gm.config.doors_min_rest_time, gm.config.doors_max_rest_time))
	else:
		gm.lose()


func _on_left_door_pressed() -> void:
	_defending_left = true


func _on_right_door_pressed() -> void:
	_defending_left = false
