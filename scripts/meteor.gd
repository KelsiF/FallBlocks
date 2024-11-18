extends RigidBody2D

var onImmortality = false

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	Main.immortalitySignal.connect(_on_immortality_signal)
		

# Called every frame. 'delta' is the elapsed time since the previous frame.
@warning_ignore("unused_parameter")
func _process(delta: float) -> void:
	pass


@warning_ignore("unused_parameter")
func _on_body_entered(body: Node) -> void:
	if body.name == "Player":
		if onImmortality == false:
			await call_deferred("queue_free")
			Main.playerDead.emit()
		else:
			print("Вы не погибли!")
	if body.name == "Area2D":
		$Sprite2D.hide()
		$CollisionShape2D.call_deferred("queue_free")
		$CPUParticles2D.call_deferred("queue_free")
		$breakingParticles.emitting = true
		await get_tree().create_timer(1.0).timeout
		await call_deferred("queue_free")

func _on_immortality_signal():
	onImmortality = true
	print("immortality buff")
	buff_timer(3.0)


func buff_timer(sec: float):
	var i = 0
	while i < sec:
		await get_tree().create_timer(1.0).timeout
		#изменение оставшегося времени
		i += 1
