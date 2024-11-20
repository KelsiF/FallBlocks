extends RigidBody2D

var debuffs = ["slow", "gigant", "blidness"]
var debuff = "null"
var rng = RandomNumberGenerator.new()

@warning_ignore("unused_parameter")
func _ready() -> void:
	var debuff_number = rng.randi_range(0, 2)
	debuff = debuffs[debuff_number]


@warning_ignore("unused_parameter")
func _on_body_entered(body: Node) -> void:
	if body.name == "Player":
		await call_deferred("queue_free")
		match debuff:
			"slow":
				slow_debuff()
			"gigant":
				gigant_debuff()
			"blidness":
				blidness_debuff()


func slow_debuff():
	Main.slowSignal.emit()

func gigant_debuff():
	Main.gigantSignal.emit()

func blidness_debuff():
	Main.blidnessSignal.emit()
