extends Node2D



func _on_play_mouse_entered() -> void:
	$Play/Sprite2D.scale.x = 1.0
	$Play/Sprite2D.scale.y = 1.0



func _on_play_mouse_exited() -> void:
	$Play/Sprite2D.scale.x = 1.5
	$Play/Sprite2D.scale.y = 1.5
