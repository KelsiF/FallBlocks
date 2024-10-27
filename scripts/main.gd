extends Node2D

var meteor = preload("res://meteor.tscn")

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	spawn_meteors(0)


# Called every frame. 'delta' is the elapsed time since the previous frame.
@warning_ignore("unused_parameter")
func _process(delta: float) -> void:
	pass

func spawn_meteors(count):
	var rng = RandomNumberGenerator.new()
	
	if count == null:
		count = 0

	while count < 1:
		var x = rng.randf_range(65, 1216)
		var y = rng.randf_range(-70, -900)
		var instance = meteor.instantiate()
		instance.position = Vector2(x, y)
		await get_tree().create_timer(rng.randf_range(0.1, 1)).timeout
		add_child(instance)
		
