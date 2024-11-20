extends Node2D

signal playerDead

#buffs signals
signal sprintSignal
signal miniSignal
signal immortalitySignal

#debuff signals
signal slowSignal
signal gigantSignal
signal blidnessSignal

#label signals
signal buff_textSignal
signal buff_default_textSignal

var playerIsDead = false
var meteor = preload("res://meteor.tscn")
var buff = preload("res://buff.tscn")
var debuff = preload("res://debuff.tscn")
# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	spawn_meteors(0)
	spawn_buffs()
	Main.playerDead.connect(_on_player_dead)
	
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
	
	
	while playerIsDead == false:
		var x = rng.randf_range(0, 1270)
		var y = rng.randf_range(-70, -900)
		var instance = meteor.instantiate()
		instance.position = Vector2(x, y)
		await get_tree().create_timer(rng.randf_range(0.1, 0.5)).timeout
		add_child(instance)

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
				await get_tree().create_timer(0.5)
				add_child(instanceBuff)
			elif (buffOrDebuff < 50):
				var instanceDebuff = debuff.instantiate()
				instanceDebuff.position = Vector2(rng.randf_range(0, 1270), rng.randf_range(-70, -900))
				await get_tree().create_timer(0.5)
				add_child(instanceDebuff)

func initialize_buffs():
	Main.sprintSignal.connect(_on_buff)
	Main.miniSignal.connect(_on_buff)
	Main.assasinSignal.connect(_on_buff)
	Main.immortalitySignal.connect(_on_buff)
	Main.double_chanceSignal.connect(_on_buff)
	Main.slowSignal.connect(_on_buff)
	Main.gigantSignal.connect(_on_buff)
	Main.blidness.connect(_on_buff)
