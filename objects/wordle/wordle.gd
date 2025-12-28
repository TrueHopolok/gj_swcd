class_name Wordle
extends Node2D


'''
SFX todo:
	- Switch dice
	- Spawn
	- New threat

Animations / images todo:
	- Dice with letters (make it godot theme)
'''

@onready var gmconfig: DifficultyConfig = GameManager.get_config()

var is_locked: bool = false

@onready var _letter_1: Button = $VBoxContainer/HBoxContainer/Letter1
@onready var _letter_2: Button = $VBoxContainer/HBoxContainer/Letter2
@onready var _letter_3: Button = $VBoxContainer/HBoxContainer/Letter3
@onready var _letter_4: Button = $VBoxContainer/HBoxContainer/Letter4
@onready var _word: Label = $VBoxContainer/Word

const _alphabet := [
	"A","B","C","D","E","F","G","H","I","J","K","L","M",
	"N","O","P","Q","R","S","T","U","V","W","X","Y","Z"
]

var _words = [
  ["NOEL", 0],
  ["YEAR", 0],
  ["TIME", 2],
  ["EVEE", 0],
  ["STAR", 1],
  ["SNOW", 1],
  ["COLD", 0],
  ["WISH", 3],
  ["HOPE", 0],
  ["JOYS", 0],
  ["FIRE", 0],
  ["SPAR", 1],
  ["BOOM", 3],
  ["DROP", 3],
  ["KISS", 0],
  ["SHOT", 1],
  ["RING", 0],
  ["PRAY", 3],
  ["VOWS", 0],
  ["PLAN", 3]
]
var _box: Array = [["HEGR", 0], ["EGR", 0], ["LPO", 0], ["POG", 0]]
var _answer: String
var _chance: float = 0.0


func _ready() -> void:
	_update_wordle(0)
	get_tree().get_first_node_in_group("NightTimer").hour_passed.connect(_update_wordle)


func _update_wordle(hour: int) -> void:
	if gmconfig.wordle_chance.has(hour):
		_chance = gmconfig.wordle_chance[hour]


func _activate() -> void:
	_letter_1.disabled = false
	_letter_2.disabled = false
	_letter_3.disabled = false
	_letter_4.disabled = false


func _deactivate() -> void:
	_letter_1.disabled = true
	_letter_2.disabled = true
	_letter_3.disabled = true
	_letter_4.disabled = true


func generate_new_word() -> void:
	if is_locked: return
	if _chance < randf(): return
	
	is_locked = true
	
	var rng: int = randi() % len(_words)
	_answer = _words[rng][0]
	_word.text = _answer
	var unique_index: int = _words[rng][1]
	for i in range(4):
		var opts: Array[String] = []
		var correct: String = _answer[i]
		opts.append(correct)

		while opts.size() < 4:
			var c: String = _alphabet[randi() % _alphabet.size()]
			if not opts.has(c):
				opts.append(c)

		opts.shuffle()

		var opt_str := ""
		for c in opts:
			opt_str += c

		_box[i][0] = opt_str
		_box[i][1] = randi() % len(opt_str)
		
	_letter_1.text = _box[0][0][_box[0][1]]
	_letter_2.text = _box[1][0][_box[1][1]]
	_letter_3.text = _box[2][0][_box[2][1]]
	_letter_4.text = _box[3][0][_box[3][1]]
	_activate()
	if unique_index == 0:
		_letter_1.disabled = true
		_letter_1.text = _answer[0]
		_box[0][0][_box[0][1]] = _answer[0]
	elif unique_index == 1:
		_letter_2.disabled = true
		_letter_2.text = _answer[1]
		_box[1][0][_box[1][1]] = _answer[1]
	elif unique_index == 2:
		_letter_3.disabled = true
		_letter_3.text = _answer[2]
		_box[2][0][_box[2][1]] = _answer[2]
	elif unique_index == 3:
		_letter_4.disabled = true
		_letter_4.text = _answer[3]
		_box[3][0][_box[3][1]] = _answer[3]
	validate()
	

func validate() -> void:
	if _box[0][0][_box[0][1]]+_box[1][0][_box[1][1]]+_box[2][0][_box[2][1]]+_box[3][0][_box[3][1]] == _answer:
		is_locked = false
		_deactivate()


func _on_letter_1_pressed() -> void:
	_box[0][1] = (_box[0][1] + 1)  % len(_box[0][0])
	_letter_1.text = _box[0][0][_box[0][1]]
	validate()


func _on_letter_2_pressed() -> void:
	_box[1][1] = (_box[1][1] + 1)  % len(_box[1][0])
	_letter_2.text = _box[1][0][_box[1][1]]
	validate()


func _on_letter_3_pressed() -> void:
	_box[2][1] = (_box[2][1] + 1)  % len(_box[2][0])
	_letter_3.text = _box[2][0][_box[2][1]]
	validate()


func _on_letter_4_pressed() -> void:
	_box[3][1] = (_box[3][1] + 1)  % len(_box[3][0])
	_letter_4.text = _box[3][0][_box[3][1]]
	validate()
