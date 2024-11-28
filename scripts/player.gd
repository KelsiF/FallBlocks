extends CharacterBody2D

var speed = 300
var speedMultiplier = 1.0

var onImmortality = false

func on_dead():
	await call_deferred("queue_free")

func _ready():
	$AnimatedSprite2D.play("default")	
	Main.playerDead.connect(_on_player_dead)
	Main.sprintSignal.connect(_on_sprint_signal)
	Main.miniSignal.connect(_on_mini_signal)
	Main.immortalitySignal.connect(_on_immortality_signal)
	Main.slowSignal.connect(_on_slow_signal)
	Main.gigantSignal.connect(_on_gigant_signal)


func _physics_process(delta):
	player_falling(delta)
	player_run(delta)
	player_jump(delta)
	
	move_and_slide()

func player_falling(delta):
	if !is_on_floor():
		velocity.y += 1000 * delta
		

@warning_ignore("unused_parameter")
func player_run(delta):
	var direction = Input.get_axis("left", "right")
	if direction:
		velocity.x = direction * speed*speedMultiplier
	else:
		velocity.x = move_toward(velocity.x, 0, speed*speedMultiplier)
	if Input.is_action_pressed("left"):
		$AnimatedSprite2D.flip_h = true
	if Input.is_action_pressed("right"):
		$AnimatedSprite2D.flip_h = false

@warning_ignore("unused_parameter")
func player_jump(delta):
	if Input.is_action_just_pressed("jump"):
		if is_on_floor():
			velocity.y = -400
			
func _on_player_dead():
	$AnimatedSprite2D.hide()
	$CPUParticles2D.emitting = true
	$CollisionShape2D.call_deferred("queue_free")
	await get_tree().create_timer(3.0).timeout
	get_tree().reload_current_scene()

#buff functions

func _on_sprint_signal():
	speedMultiplier = 1.5
	buff_timer(5.0, "Sprint")

func _on_mini_signal():
	scale.x = 0.5
	scale.y = 0.5
	buff_timer(3.5, "Decrease in size")

func _on_immortality_signal():
	onImmortality = true
	buff_timer(3.5, "Immortality")

#debuff functions
func _on_slow_signal():
	speedMultiplier = 0.5
	debuff_timer(5.0, "Slowdown")
func _on_gigant_signal():
	scale.x = 1.5
	scale.y = 1.5
	debuff_timer(5.0, "Increase in size")

func buff_timer(sec: float, buff: String):
	var i = 0
	Main.buff_textSignal.emit(buff, sec-i)
	while i <= sec:
		await get_tree().create_timer(1.0).timeout
		Main.buff_textSignal.emit(buff, sec-i)
		print(str(i) + " " + str(sec))
		i += 1
	if  i >= sec:
		Main.buff_default_textSignal.emit()
		
		match buff:
			"Sprint":
				speedMultiplier = 1.0
			"Decrease in size":
				scale.x = 1
				scale.y = 1
			"Immortality":
				onImmortality = false

func debuff_timer(sec: float, debuff: String):
	var i = 0
	
	while i <= sec:
		await get_tree().create_timer(1.0).timeout
		Main.debuff_textSignal.emit(debuff, sec-i)
		print(str(i) + " " + str(sec))
		i += 1
	if i >= sec:
		Main.debuff_default_textSignal.emit()
		
		match debuff:
			"Slowdown":
				speedMultiplier = 1.0
			"Increase in size":
				scale.x = 1.0
				scale.y = 1.0
