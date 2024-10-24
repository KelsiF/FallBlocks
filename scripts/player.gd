extends CharacterBody2D


func _ready():
	pass


func _physics_process(delta):
	player_falling(delta)
	player_run(delta)
	player_jump(delta)
	
	move_and_slide()

func player_falling(delta):
	if !is_on_floor():
		velocity.y += 1000 * delta
		

func player_run(delta):
	var direction = Input.get_axis("left", "right")
	
	if direction:
		velocity.x = direction * 300
	else:
		velocity.x = move_toward(velocity.x, 0, 300)

func player_jump(delta):
	if Input.is_action_just_pressed("jump"):
		if is_on_floor():
			velocity.y = -400
