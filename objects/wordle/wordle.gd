extends Node2D

@onready var letter_1: Button = $HBoxContainer/Letter1
@onready var letter_2: Button = $HBoxContainer/Letter2
@onready var letter_3: Button = $HBoxContainer/Letter3
@onready var letter_4: Button = $HBoxContainer/Letter4

const alphabet := [
	"A","B","C","D","E","F","G","H","I","J","K","L","M",
	"N","O","P","Q","R","S","T","U","V","W","X","Y","Z"
]

var words = [
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
var box: Array = [["HEGR", 0], ["EGR", 0], ["LPO", 0], ["POG", 0]]
var answer: String

func _ready() -> void:
	generate_new_word()

func generate_new_word() -> void:
	var rng: int = randi() % len(words)
	answer = words[rng][0]
	var unique_index: int = words[rng][1]
	for i in range(4):
		var opts: Array[String] = []
		var correct: String = answer[i]
		opts.append(correct)

		while opts.size() < 4:
			var c: String = alphabet[randi() % alphabet.size()]
			if not opts.has(c):
				opts.append(c)

		opts.shuffle()

		var opt_str := ""
		for c in opts:
			opt_str += c

		box[i][0] = opt_str
		box[i][1] = randi() % len(opt_str)
	letter_1.disabled = false
	letter_2.disabled = false
	letter_3.disabled = false
	letter_4.disabled = false
	if unique_index == 0:
		letter_1.disabled = true
		letter_1.text = answer[0]
		box[0][0][box[0][1]] = answer[0]
	elif unique_index == 1:
		letter_2.disabled = true
		letter_2.text = answer[1]
		box[1][0][box[1][1]] = answer[1]
	elif unique_index == 2:
		letter_3.disabled = true
		letter_3.text = answer[2]
		box[2][0][box[2][1]] = answer[2]
	elif unique_index == 3:
		letter_4.disabled = true
		letter_4.text = answer[3]
		box[3][0][box[3][1]] = answer[3]
	

func validate() -> void:
	if box[0][0][box[0][1]]+box[1][0][box[1][1]]+box[2][0][box[2][1]]+box[3][0][box[3][1]] == answer:
		print("CORRECT")
	

func _on_letter_1_pressed() -> void:
	box[0][1] = (box[0][1] + 1)  % len(box[0][0])
	letter_1.text = box[0][0][box[0][1]]
	validate()
	
func _on_letter_2_pressed() -> void:
	box[1][1] = (box[1][1] + 1)  % len(box[1][0])
	letter_2.text = box[1][0][box[1][1]]
	validate()
	
func _on_letter_3_pressed() -> void:
	box[2][1] = (box[2][1] + 1)  % len(box[2][0])
	letter_3.text = box[2][0][box[2][1]]
	validate()

func _on_letter_4_pressed() -> void:
	box[3][1] = (box[3][1] + 1)  % len(box[3][0])
	letter_4.text = box[3][0][box[3][1]]
	validate()
