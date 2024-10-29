extends CharacterBody2D

func on_dead():
	await call_deferred("queue_free")

func _ready():
	$AnimatedSprite2D.play("default")	
	Main.playerDead.connect(_on_player_dead)
	await get_tree().create_timer(5.0).timeout
	print("timer")


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

@warning_ignore("unused_parameter")
func player_jump(delta):
	if Input.is_action_just_pressed("jump"):
		if is_on_floor():
			velocity.y = -400
			
func _on_player_dead():
	hide()
	await get_tree().create_timer(1.0).timeout
	get_tree().reload_current_scene()
