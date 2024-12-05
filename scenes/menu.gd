extends Node2D



func _on_play_mouse_entered() -> void:
	await get_tree().create_timer(0.1).timeout
	$Play.scale = Vector2(1.0, 1.0)

func _on_play_mouse_exited() -> void:
	await get_tree().create_timer(0.1).timeout
	$Play.scale = Vector2(1.5, 1.5)

func _on_play_pressed() -> void:
		get_tree().change_scene_to_file("res://scenes/1 level.tscn")
