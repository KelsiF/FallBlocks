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
		get_tree().reload_current_scene()
		print("scene reloaded")
	if body.name == "Area2D":
		await call_deferred("queue_free")
		print("block fall on ground")
