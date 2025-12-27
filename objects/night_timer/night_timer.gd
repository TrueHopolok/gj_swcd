extends Control


@onready var gm: GameManager = GameManager.get_instance()
@onready var _hour_timer: Timer = $HourTimer
@onready var _hour_label: Label = $HourLabel
var _current_hour: int = 0


func _ready() -> void:
	_hour_timer.start(Global.night_hour_length)


func _hour_passed() -> void:
	_current_hour += 1
	if _current_hour == 6:
		gm.win()
	_hour_label.text = "%d AM" % _current_hour
