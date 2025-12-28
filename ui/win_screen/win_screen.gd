extends Control

func _on_try_again_button_pressed() -> void:
	get_tree().change_scene_to_file("res://scenes/house/house.tscn")

func _on_main_menu_button_pressed() -> void:
	pass # TODO
