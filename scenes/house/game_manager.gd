class_name GameManager
extends Node2D

## Difficulty of the game can be changed here.
@export var config: DifficultyConfig


static func get_instance() -> GameManager:
	return Engine.get_main_loop().get_first_node_in_group("GameManager")


static func get_config() -> DifficultyConfig:
	return Engine.get_main_loop().get_first_node_in_group("GameManager").config


func win() -> void:
	get_tree().reload_current_scene()
	# TODO: switch to win screen


func lose() -> void:
	get_tree().change_scene_to_file("res://ui/death_screen/death_screen.tscn")
	# TODO: switch to lose screen


func _ready() -> void:
	%TransitionRect.color.a = 1.0
	$RightRoom.enter()
