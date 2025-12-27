class_name DifficultyConfig
extends Resource


## Oven difficulty related variables.
## Maximum units amount in the oven is 120 and starting is 100.
@export_group("Oven")
## How fast oven cool down in units/second. More info in group's doc.
@export_range(0.0, 10.0, 0.05) var oven_cooling_speed: float = 1.0
## How much 1 log restores units of warmth. More info in group's doc.
@export_range(0.0, 100.0, 1.0) var oven_heating_per_log: float = 30.0


## Wordle difficulty related variables.
@export_group("Wordle")
## Stores chance for wordle to appear on each hour.
## If 0 is not present, chance is set to 0.
@export var wordle_chance: Dictionary = {}


## MusicBox difficulty related variables.
@export_group("MusicBox")
@export var SLOW_WINDOW: float = 20.0      
@export var SILENT_AT: float = 10.0  


## WindowNBlind difficulty related variables.
@export_group("WindowNBlind")
## Starting rest time before actiavtes. Activation calls rest first.
@export_range(0.0, 100.0, 0.01) var window_start_time: float = 60.0
## Min rest time between attacks.
@export_range(0.0, 100.0, 0.01) var window_min_rest_time: float = 10.0
## Max rest time between attacks.
@export_range(0.0, 100.0, 0.01) var window_max_rest_time: float = 20.0
## Time before kill / to defend.
@export_range(0.0, 100.0, 0.01) var window_attack_time: float = 10.0


## DoubleDoors difficulty related variables.
@export_group("DoubleDoors")
## Starting rest time before actiavtes. Activation calls rest first.
@export_range(0.0, 100.0, 0.01) var doors_start_time: float = 60.0
## Min rest time between attacks.
@export_range(0.0, 100.0, 0.01) var doors_min_rest_time: float = 10.0
## Max rest time between attacks.
@export_range(0.0, 100.0, 0.01) var doors_max_rest_time: float = 20.0
## Time before kill / to defend.
@export_range(0.0, 100.0, 0.01) var doors_attack_time: float = 10.0
