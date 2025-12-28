class_name Log
extends Node2D

@onready var pickup: SpatialAudioSource = $pickup
@onready var oven: Oven = get_tree().get_first_node_in_group("Oven")

var pickeable: bool = true

func _on_button_pressed() -> void:
	if pickeable && !oven.has_log:
		pickup.play(0)
		oven.has_log = true
		visible = false
		pickeable = false
