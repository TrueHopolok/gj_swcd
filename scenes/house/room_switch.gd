class_name Room
extends Node2D


'''
SFX todo:
	- moving through
'''


@export var room_to_the_left: Room
@export var room_to_the_right: Room
@export var wordle: Wordle

@onready var gm: GameManager = GameManager.get_instance()
@onready var gmconfig: DifficultyConfig = GameManager.get_config()
@onready var _transition_rect: ColorRect = %TransitionRect
@onready var _wordle_room: bool = is_instance_valid(wordle)
var _ignore_input: bool = true


func _input(event: InputEvent) -> void:
	if _ignore_input: return
	if _wordle_room && wordle.is_locked: return
	if event.is_action_pressed("move_left"):
		if is_instance_valid(room_to_the_left):
			_leave(true)
			gm.moved_left.emit()
	elif event.is_action_pressed("move_right"):
		if is_instance_valid(room_to_the_right):
			_leave(false)
			gm.moved_right.emit()


func _leave(move_left: bool) -> void:
	# TODO: gm.immune(true)
	_ignore_input = true
	var tween = get_tree().create_tween()
	tween.tween_property(_transition_rect, "color:a", 1.0, gmconfig.room_transition_time / 2)
	tween.tween_callback(hide)
	tween.tween_callback(room_to_the_left.enter if move_left else room_to_the_right.enter)


func enter() -> void:
	show()
	if _wordle_room:
		wordle.generate_new_word()
	var tween = get_tree().create_tween()
	tween.tween_property(_transition_rect, "color:a", 0.0, gmconfig.room_transition_time / 2)
	tween.tween_callback(func() -> void:
		# TODO: gm.immune(false)
		await get_tree().create_timer(gmconfig.room_unswitchable_time).timeout
		_ignore_input = false
	)
