extends Control

@onready var general_slider: HSlider = $AudioSettings/VBoxContainer/GeneralSlider
@onready var music_slider: HSlider = $AudioSettings/VBoxContainer/MusicSlider
@onready var sfx_slider: HSlider = $AudioSettings/VBoxContainer/SFXSlider
@onready var toggle_hints: CheckButton = $Difficulties/Hints/ToggleHints

const EASY = "res://scenes/house/difficulties/difficulty_easy.tres"
const MEDIUM = "res://scenes/house/difficulties/difficulty_medium.tres"
const HARD = "res://scenes/house/difficulties/difficulty_hard.tres"
const UNFAIR = "res://scenes/house/difficulties/difficulty_unfair.tres"
const SPAM = "res://scenes/house/difficulties/difficulty_spam.tres"
const SPIN = "res://scenes/house/difficulties/difficulty_spin.tres"
const HOUSE = "res://scenes/house/house.tscn"


var config = ConfigFile.new()

func _ready() -> void:
	$Difficulties/Hints/ToggleHints.button_pressed = Global.hints_enabled
	config.load("user://config.cfg")
	general_slider.value = config.get_value("Audio", "General", 100)
	music_slider.value = config.get_value("Audio", "Music", 100)
	sfx_slider.value = config.get_value("Audio", "SFX", 100)
	toggle_hints.button_pressed = config.get_value("Gameplay", "Hints", true)
	

func _save_config():
	config.set_value("Audio", "General", general_slider.value)
	config.set_value("Audio", "Music", music_slider.value)
	config.set_value("Audio", "SFX", sfx_slider.value)
	config.set_value("Gameplay", "Hints", toggle_hints.button_pressed)
	config.save("user://config.cfg")
	

func _load_level() -> void:
	_save_config()
	var pk := preload(HOUSE)
	var house := pk.instantiate()
	house.config = load(Global.difficulty)

	var root := get_tree().root
	var old_scene := get_tree().current_scene

	root.add_child(house)
	get_tree().current_scene = house

	old_scene.queue_free()
	

func _on_easy_pressed() -> void:
	Global.difficulty = EASY
	_load_level()



func _on_hard_pressed() -> void:
	Global.difficulty = HARD
	_load_level()


func _on_unfair_pressed() -> void:
	Global.difficulty = UNFAIR
	_load_level()


func _on_medium_pressed() -> void:
	Global.difficulty = MEDIUM
	_load_level()


func _on_hint_button_toggled(toggled_on: bool) -> void:
	Global.hints_enabled = toggled_on


func _on_spin_pressed() -> void:
	Global.difficulty = SPIN
	_load_level()


func _on_spam_pressed() -> void:
	Global.difficulty = SPAM
	_load_level()
