extends RigidBody2D

var buffs = ["sprint", "mini", "assasin", "immortality", "double_chance"]
var buff = "null"
var rng = RandomNumberGenerator.new()

@warning_ignore("unused_parameter")
func _ready() -> void:
	var buff_number = rng.randi_range(1, 5)
	buff = buffs[buff_number]

@warning_ignore("unused_parameter")
func _process(delta: float) -> void:
	pass


@warning_ignore("unused_parameter")
func _on_body_entered(body: Node) -> void:
	if body.name == "Player":
		await call_deferred("queue_free")
		
		match buff:
			"sprint":
				print("sprint")
			"mini":
				print("mini")
			"assasin":
				print("assasin")
			"immortality":
				print("immortality")
			"double_chance":
				print("double_chance")


func sprint_buff(default_speed, multiplier):
	Main.sprintSignal.emit()
