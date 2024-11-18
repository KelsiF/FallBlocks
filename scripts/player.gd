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

func _on_sprint_signal():
	speedMultiplier = 1.5
	print("sprint buff")
	buff_timer(5.0, "Ускорение")

func _on_mini_signal():
	var sizeMultiplier = 0.5
	scale *= sizeMultiplier
	print("mini buff")
	buff_timer(5.0, "Уменьшение")

func _on_immortality_signal():
	onImmortality = true
	print("immortality buff")
	buff_timer(3.0, "Бессмертие")


func buff_timer(sec: float, buff: String):
	var i = 0
	while i < sec:
		await get_tree().create_timer(1.0).timeout
		Main.buff_textSignal.emit(buff, sec-i)
		i += 1
	if  i >= sec:
		Main.buff_default_textSignal.emit()
