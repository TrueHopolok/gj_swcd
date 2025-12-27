class_name GameManager
extends Node2D

## Difficulty of the game can be changed here.
@export var config: DifficultyConfig

## Here are variables that are stored as state of the game.
## They have starting values.

var heat: float = 100.0
var has_log: bool = false
var wordle_chance: float = 0.0


static func get_instance() -> GameManager:
	return Engine.get_main_loop().get_first_node_in_group("GameManager")


func win() -> void:
	get_tree().reload_current_scene()
	# TODO: switch to win screen


func lose() -> void:
	get_tree().reload_current_scene()
	# TODO: switch to lose screen


func _ready() -> void:
	%TransitionRect.color.a = 1.0
	$RightRoom.enter()
