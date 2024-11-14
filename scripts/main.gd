extends Node2D

signal playerDead

var playerIsDead = false
var meteor = preload("res://meteor.tscn")
var buff = preload("res://buff.tscn")
var debuff = preload("res://debuff.tscn")
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
	var chanceBuff = 1
	var buffSpawned = false
	
	
	while playerIsDead == false:
		var x = rng.randf_range(0, 1270)
		var y = rng.randf_range(-70, -900)
		var instance = meteor.instantiate()
		instance.position = Vector2(x, y)
		await get_tree().create_timer(rng.randf_range(0.1, 0.5)).timeout
		add_child(instance)
		
		chanceBuff = rng.randi_range(1, 100)
		if (chanceBuff >= 10):
			buffSpawned = true
		if (buffSpawned):
			var buffOrDebuff = rng.randi_range(1, 100)
			if (buffOrDebuff >= 50):
				var instanceBuff = buff.instantiate()
				instanceBuff.position = Vector2(rng.randf_range(0, 1270), rng.randf_range(-70, -900))
				await get_tree().create_timer(0.5)
				add_child(instanceBuff)
			elif (buffOrDebuff < 50):
				var instanceDebuff = debuff.instantiate()
				instanceDebuff.position = Vector2(rng.randf_range(0, 1270), rng.randf_range(-70, -900))
				await get_tree().create_timer(0.5)
				add_child(instanceDebuff)
