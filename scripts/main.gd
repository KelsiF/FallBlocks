extends Node2D

signal playerDead

var playerIsDead = false
var meteor = preload("res://meteor.tscn")
# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	spawn_meteors(0)
	Main.playerDead.connect(_on_player_dead)


# Called every frame. 'delta' is the elapsed time since the previous frame.
@warning_ignore("unused_parameter")
func _process(delta: float) -> void:
	pass

func _on_player_dead():
	playerIsDead = true	

func spawn_meteors(count):
	var rng = RandomNumberGenerator.new()
	
	while playerIsDead == false:
		var x = rng.randf_range(65, 1216)
		var y = rng.randf_range(-70, -900)
		var instance = meteor.instantiate()
		instance.position = Vector2(x+rng.randf_range(-20, 20), y+rng.randf_range(-20, 20))
		await get_tree().create_timer(rng.randf_range(0.1, 1)).timeout
		add_child(instance)		
