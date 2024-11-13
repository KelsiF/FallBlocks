extends CharacterBody2D

func on_dead():
	await call_deferred("queue_free")

func _ready():
	$AnimatedSprite2D.play("default")	
	Main.playerDead.connect(_on_player_dead)


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
		velocity.x = direction * 300
	else:
		velocity.x = move_toward(velocity.x, 0, 300)
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
