extends Control

const EASY = "res://scenes/house/difficulties/difficulty_easy.tres"
const HARD = "res://scenes/house/difficulties/difficulty_hard.tres"
const UNFAIR = "res://scenes/house/difficulties/difficulty_unfair.tres"
const HOUSE = "res://scenes/house/house.tscn"

@onready var difficulty_selector: AspectRatioContainer = $CenterContainer/HBoxContainer/DifficultySelector

func _on_play_button_pressed() -> void:
	difficulty_selector.visible = !difficulty_selector.visible

func _on_audio_settings_pressed() -> void:
	get_tree().change_scene_to_file("res://ui/audio_settings/audio_settings.tscn")
	
func _on_exit_pressed() -> void:
	get_tree().quit(0)


func _on_easy_pressed() -> void:
	Global.difficulty = EASY
	var pk := preload(HOUSE)
	var house := pk.instantiate()
	house.config = load(EASY)

	var root := get_tree().root
	var old_scene := get_tree().current_scene

	root.add_child(house)
	get_tree().current_scene = house

	old_scene.queue_free()


func _on_hard_pressed() -> void:
	Global.difficulty = HARD
	var pk := preload(HOUSE)
	var house := pk.instantiate()
	house.config = load(HARD)
	
	var root := get_tree().root
	var old_scene := get_tree().current_scene

	root.add_child(house)
	get_tree().current_scene = house

	old_scene.queue_free()


func _on_unfair_pressed() -> void:
	Global.difficulty = UNFAIR
	var pk := preload(HOUSE)
	var house := pk.instantiate()
	house.config = load(UNFAIR)

	var root := get_tree().root
	var old_scene := get_tree().current_scene

	root.add_child(house)
	get_tree().current_scene = house

	old_scene.queue_free()


func _on_hint_button_toggled(toggled_on: bool) -> void:
	Global.hints_enabled = toggled_on
