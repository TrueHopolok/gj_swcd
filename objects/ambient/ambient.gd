extends Node2D


var sfxs: Array[AudioStreamPlayer2D]
var ind: int = 0


func _ready() -> void:
	for child in get_children():
		sfxs.append(child)
		child.finished.connect(_done_sound)
	_done_sound()


func _done_sound() -> void:
	if ind >= len(sfxs) - 1:
		sfxs.shuffle()
		ind = 0
	get_tree().create_timer(randf_range(5.0, 20.0)).timeout.connect(_exec_sound)


func _exec_sound() -> void:
	sfxs[ind].play()
	ind += 1
