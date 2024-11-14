extends RigidBody2D

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass
		

# Called every frame. 'delta' is the elapsed time since the previous frame.
@warning_ignore("unused_parameter")
func _process(delta: float) -> void:
	pass


@warning_ignore("unused_parameter")
func _on_body_entered(body: Node) -> void:
	if body.name == "Player":
		await call_deferred("queue_free")
		Main.playerDead.emit()
	if body.name == "Area2D":
		$Sprite2D.hide()
		$CollisionShape2D.call_deferred("queue_free")
		$CPUParticles2D.call_deferred("queue_free")
		$breakingParticles.emitting = true
		await get_tree().create_timer(1.0).timeout
		await call_deferred("queue_free")
