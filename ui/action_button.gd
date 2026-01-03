extends Button

@export var action_executed: StringName
@onready var _prep_action = InputEventAction.new()


func _ready() -> void:
	visible = OS.get_name() == "Android" || OS.get_name() == "Web"
	if visible:
		_prep_action.action = action_executed
		_prep_action.pressed = true


func _on_pressed() -> void:
	Input.parse_input_event(_prep_action)
