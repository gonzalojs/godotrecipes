extends CharacterBody2D


@export var speed = 500.0
@export var gravity = 2000.0
@export var jump_strength = 800.0

@export_category("actions")
@export var move_left_action = "move_left"
@export var move_rigth_action = "move_rigth"
@export var jump_action = "jump"

var direction = 0

func _physics_process(delta):
	velocity.y += gravity * delta
	velocity.x = direction.x * speed
	
	move_and_slide()

func _unhandled_input(event):
	# Horizontal Movement
	if event.is_action(move_left_action):
		if event.is_pressed():
			direction = -1
		elif Input.is_action_pressed(move_rigth_action):
				direction = 1
		else:
			direction = 0
	elif event.is_action(move_rigth_action):
		if event.is_pressed():
			direction = 1
		elif Input.is_action_pressed(move_left_action):
			direction = -1
		else:
			direction = 0
	
	# Vertical movement
	if event.is_action_pressed(jump_action):
		jump()
	elif event.is_action_released(jump_action):
		cancel_jump()

func jump():
	if is_on_floor():
		velocity.y = -jump_strength

func cancel_jump():
	if not is_on_floor() and velocity.y < 0.0:
		velocity.y = 0.0
