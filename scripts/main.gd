extends Node2D

signal playerDead

#buffs signals
signal sprintSignal
signal miniSignal
signal immortalitySignal

#debuff signals
signal slowSignal
signal gigantSignal

#label signals
signal buff_textSignal
signal buff_default_textSignal

signal debuff_textSignal
signal debuff_default_textSignal

signal score_changeSignal

var playerIsDead = false
var meteor = preload("res://scenes/meteor.tscn")
var buff = preload("res://scenes/buff.tscn")
var debuff = preload("res://scenes/debuff.tscn")
var none_buff = preload("res://scenes/none_buff.tscn")

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	if get_tree().current_scene.name == "1 level":
		spawn_meteors(0)
		spawn_buffs()

	Main.playerDead.connect(_on_player_dead)
	Main.score_changeSignal.connect(_on_buff)
	
	#buffs signals initialize
	initialize_buffs()
	


# Called every frame. 'delta' is the elapsed time since the previous frame.
@warning_ignore("unused_parameter")
func _process(delta: float) -> void:
	pass

func _on_player_dead():
	playerIsDead = true	

func _on_buff():
	pass

func spawn_meteors(count):
	var rng = RandomNumberGenerator.new()
	
	# проверка конкретной сцены, является ли она игровым уровнем
	if get_tree().current_scene.name == "1 level":
	
		while playerIsDead == false:
			var x = rng.randf_range(0, 1270)
			var y = rng.randf_range(-70, -900)
			var instance = meteor.instantiate()
			instance.position = Vector2(x, y)
			await get_tree().create_timer(rng.randf_range(0.1, 0.5)).timeout
			add_child(instance)
	else:
		print("this is not level")

func spawn_buffs():
	
	var rng = RandomNumberGenerator.new()
	var chanceBuff = 1
	var buffSpawned = false
	
	
	while playerIsDead == false:
		await get_tree().create_timer(10.0).timeout
		chanceBuff = rng.randi_range(1, 100)
		if (chanceBuff <= 50):
			buffSpawned = true
		if (buffSpawned):
			var buffOrDebuff = rng.randi_range(1, 100)
			if (buffOrDebuff >= 50):
				var instanceBuff = buff.instantiate()
				instanceBuff.position = Vector2(rng.randf_range(0, 1270), rng.randf_range(-70, -900))
				await get_tree().create_timer(0.5).timeout
				add_child(instanceBuff)
				
				if rng.randi_range(1, 100) <= 25:
					var instanceNone = none_buff.instantiate()
					instanceNone.position = Vector2(rng.randf_range(0, 1270), rng.randf_range(-70, -900))
					await get_tree().create_timer(0.5).timeout
					add_child(instanceNone)
			elif (buffOrDebuff < 50):
				var instanceDebuff = debuff.instantiate()
				instanceDebuff.position = Vector2(rng.randf_range(0, 1270), rng.randf_range(-70, -900))
				await get_tree().create_timer(0.5).timeout
				add_child(instanceDebuff)
				if rng.randi_range(1, 100) <= 25:
					var instanceNone = none_buff.instantiate()
					instanceNone.position = Vector2(rng.randf_range(0, 1270), rng.randf_range(-70, -900))
					await get_tree().create_timer(0.5).timeout
					add_child(instanceNone)

func initialize_buffs():
	Main.sprintSignal.connect(_on_buff)
	Main.miniSignal.connect(_on_buff)
	Main.immortalitySignal.connect(_on_buff)
	Main.slowSignal.connect(_on_buff)
	Main.gigantSignal.connect(_on_buff)
