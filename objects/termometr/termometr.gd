extends TextureProgressBar


@onready var oven: Oven = get_tree().get_first_node_in_group("Oven")


func _process(_delta: float) -> void:
	value = min(oven.heat, 100.0)
