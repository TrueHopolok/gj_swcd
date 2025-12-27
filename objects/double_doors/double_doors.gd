extends Node2D


@onready var gm: GameManager = GameManager.get_instance()
@onready var _start_timer: Timer 	= $StartTimer
@onready var _attack_timer: Timer 	= $AttackTimer
@onready var _rest_timer: Timer 	= $RestTimer
var _attacking_left: bool = true
var _defending_left: bool = true


func _ready() -> void:
	_start_timer.start(gm.config.doors_start_time)


func _on_start_end() -> void:
	_rest_timer.start(randf_range(gm.config.doors_min_rest_time, gm.config.doors_max_rest_time))


func _on_rest_end() -> void:
	_attacking_left = randi_range(0, 1) == 0
	_attack_timer.start(gm.config.doors_attack_time)
	#print("attacking", _attacking_left)


func _on_attack_end() -> void:
	if (_attacking_left && _defending_left) || (!_attacking_left && !_defending_left):
		#print("defended")
		_rest_timer.start(randf_range(gm.config.doors_min_rest_time, gm.config.doors_max_rest_time))
		pass
	else:
		#print("killed")
		# TODO: gm.lose()
		pass


func _on_left_door_pressed() -> void:
	_defending_left = true


func _on_right_door_pressed() -> void:
	_defending_left = false
