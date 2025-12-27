extends Node2D


'''
SFX todo:
	- Ambient fire cracking (depending on amount of fuel)

Animations / images:
	- Glow (depending on amount of fuel)
	- Oven itself
	- Fire inside
'''


@onready var gm: GameManager = GameManager.get_instance()


func _process(delta: float) -> void:
	gm.heat -= delta * gm.config.oven_cooling_speed
	if gm.heat <= 0:
		gm.lose()


func _on_oven_pressed() -> void:
	if gm.has_log:
		gm.has_log = false
		gm.heat = min(gm.heat + gm.config.oven_heating_per_log, Global.oven_max_heat)
