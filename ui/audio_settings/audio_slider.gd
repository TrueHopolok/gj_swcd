extends HSlider

var _main_menu: MainMenu

@export var bus_name: StringName 

var _bus_idx: int

func _ready() -> void:
	_bus_idx = AudioServer.get_bus_index(bus_name)
	assert(_bus_idx >= 0, "Error: non existent bus name was set for audio slider")
	_main_menu = get_tree().get_first_node_in_group("MainMenu")
	_main_menu.read_config()
	value = _main_menu.config.get_value("Audio", bus_name, 100.0)
	drag_ended.connect(_on_drag_ended)


func _on_value_changed(volume: float) -> void:
	AudioServer.set_bus_volume_linear(_bus_idx, volume / 100.0)


func _on_drag_ended(save: bool) -> void:
	if save:
		_main_menu.config.set_value("Audio", bus_name, value)
		_main_menu.save_config()
