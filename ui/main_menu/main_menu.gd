class_name MainMenu
extends Control

@onready var general_slider: HSlider = $AudioSettings/VBoxContainer/GeneralSlider
@onready var music_slider: HSlider = $AudioSettings/VBoxContainer/MusicSlider
@onready var sfx_slider: HSlider = $AudioSettings/VBoxContainer/SFXSlider
@onready var toggle_hints: CheckButton = $Difficulties/Hints/ToggleHints

const CFG_PATH = "user://config.cfg"
const EASY = "res://scenes/house/difficulties/difficulty_easy.tres"
const MEDIUM = "res://scenes/house/difficulties/difficulty_medium.tres"
const HARD = "res://scenes/house/difficulties/difficulty_hard.tres"
const UNFAIR = "res://scenes/house/difficulties/difficulty_unfair.tres"
const SPAM = "res://scenes/house/difficulties/difficulty_spam.tres"
const SPIN = "res://scenes/house/difficulties/difficulty_spin.tres"
const HOUSE = "res://scenes/house/house.tscn"

var config: ConfigFile = ConfigFile.new()

func _ready() -> void:
	$Difficulties/Hints/ToggleHints.button_pressed = Global.hints_enabled
	config.load(CFG_PATH)
	toggle_hints.button_pressed = config.get_value("Gameplay", "Hints", true)
	
func read_config():
	config.load(CFG_PATH)
	
func save_config():
	config.save(CFG_PATH)
	

func _load_level() -> void:
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
	config.set_value("Gameplay", "Hints", toggled_on)
	save_config()


func _on_spin_pressed() -> void:
	Global.difficulty = SPIN
	_load_level()


func _on_spam_pressed() -> void:
	Global.difficulty = SPAM
	_load_level()
