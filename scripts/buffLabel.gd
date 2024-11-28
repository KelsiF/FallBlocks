extends Control

var defaultText = "Buff:\n"
var debuffDefaultText = "Debuff:\n"
var timer = 0

var score = 0.0


# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	Main.buff_textSignal.connect(_on_buff_textSignal)
	Main.buff_default_textSignal.connect(_on_default_textSignal)
	Main.debuff_textSignal.connect(_on_debuff_textSignal)
	Main.debuff_default_textSignal.connect(_on_debuff_default_textSignal)
	Main.score_changeSignal.connect(_on_score_change)
	$Buff.text = defaultText + "None (" + str(timer) + ")"
	$Debuff.text = debuffDefaultText + "None (" + str(timer) + ")"
	
	changeScore()


func _on_buff_textSignal(buff, secs):
	$Buff.text = defaultText + buff + "(" + str(secs) + ")" 

func _on_default_textSignal():
	$Buff.text = defaultText + "None (" + str(timer) + ")"

func _on_debuff_textSignal(debuff, secs):
	$Debuff.text = debuffDefaultText + debuff + "(" + str(secs) + ")"

func _on_debuff_default_textSignal():
	$Debuff.text = debuffDefaultText + "None (" + str(timer) + ")" 

func _on_score_change():
	score = score + 0.5
	roundi(score)
func changeScore():
	var i = 0
	while i < 1:
		await get_tree().create_timer(0.1).timeout
		$Score.text = str(score)
