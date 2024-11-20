extends RigidBody2D

var buffs = ["sprint", "mini", "immortality"]
var buff = "null"
var rng = RandomNumberGenerator.new()

@warning_ignore("unused_parameter")
func _ready() -> void:
	var buff_number = rng.randi_range(0, 2)
	buff = buffs[buff_number]


@warning_ignore("unused_parameter")
func _on_body_entered(body: Node) -> void:
	if body.name == "Player":
		await call_deferred("queue_free")
		match buff:
			"sprint":
				sprint_buff()
			"mini":
				mini_buff()
			"immortality":
				immortality_buff()


func sprint_buff():
	Main.sprintSignal.emit()

func mini_buff():
	Main.miniSignal.emit()

func immortality_buff():
	Main.immortalitySignal.emit()
