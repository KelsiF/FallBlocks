extends Control

var defaultText = "Усиление:\n"
var timer = 0


# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	Main.buff_textSignal.connect(_on_buff_textSignal)
	Main.buff_default_textSignal.connect(_on_default_textSignal)
	$Buff.text = defaultText + "Отсутствует (" + str(timer) + ")"


func _on_buff_textSignal(buff, secs):
	$Buff.text = defaultText + buff + "(" + str(secs) + ")" 

func _on_default_textSignal():
	$Buff.text = defaultText + "Отсутствует (" + str(timer) + ")"
