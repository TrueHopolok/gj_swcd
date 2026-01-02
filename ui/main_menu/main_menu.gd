extends Control

const EASY = "res://scenes/house/difficulties/difficulty_easy.tres"
const MEDIUM = "res://scenes/house/difficulties/difficulty_medium.tres"
const HARD = "res://scenes/house/difficulties/difficulty_hard.tres"
const UNFAIR = "res://scenes/house/difficulties/difficulty_unfair.tres"
const SPAM = "res://scenes/house/difficulties/difficulty_spam.tres"
const SPIN = "res://scenes/house/difficulties/difficulty_spin.tres"

const HOUSE = "res://scenes/house/house.tscn"


func _ready() -> void:
	$Difficulties/Hints/ToggleHints.button_pressed = Global.hints_enabled


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


func _on_medium_pressed() -> void:
	Global.difficulty = MEDIUM
	var pk := preload(HOUSE)
	var house := pk.instantiate()
	house.config = load(MEDIUM)

	var root := get_tree().root
	var old_scene := get_tree().current_scene

	root.add_child(house)
	get_tree().current_scene = house

	old_scene.queue_free()


func _on_hint_button_toggled(toggled_on: bool) -> void:
	Global.hints_enabled = toggled_on


func _on_spin_pressed() -> void:
	Global.difficulty = SPIN
	var pk := preload(HOUSE)
	var house := pk.instantiate()
	house.config = load(SPIN)

	var root := get_tree().root
	var old_scene := get_tree().current_scene

	root.add_child(house)
	get_tree().current_scene = house

	old_scene.queue_free()


func _on_spam_pressed() -> void:
	Global.difficulty = SPAM
	var pk := preload(HOUSE)
	var house := pk.instantiate()
	house.config = load(SPAM)

	var root := get_tree().root
	var old_scene := get_tree().current_scene

	root.add_child(house)
	get_tree().current_scene = house

	old_scene.queue_free()
