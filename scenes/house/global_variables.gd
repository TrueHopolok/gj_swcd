extends Node

var oven_cooling_speed: float = 2.0
var oven_current_heat: float = 100.0
var oven_max_heat: float = 120.0 # ui goes up to 100, so it kinda easy
var oven_heating_per_log: float = 60.0 # a

var player_has_log: bool = false

var room_transition_time: float = 0.1
var room_unswitchable_time: float = 0.1

var music_box_rotating_power = 30
