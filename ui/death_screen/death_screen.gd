extends Control

const HOUSE = "res://scenes/house/house.tscn"

func _on_try_again_button_pressed() -> void:
	var pk := preload(HOUSE)
	var house := pk.instantiate()
	house.config = load(Global.difficulty)

	var root := get_tree().root
	var old_scene := get_tree().current_scene

	root.add_child(house)
	get_tree().current_scene = house

	old_scene.queue_free()
	
func _on_main_menu_button_pressed() -> void:
	get_tree().change_scene_to_file("res://ui/main_menu/main_menu.tscn")
