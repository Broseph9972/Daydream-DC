extends CharacterBody2D

const SPEED = 200.0
const JUMP_VELOCITY = -400.0

var body_scene = preload("res://scenes/player/Body.tscn")
var gravity = ProjectSettings.get_setting("physics/2d/default_gravity")
var starting_position = Vector2.ZERO

var bodies_to_spawn = []
var body_cooldown = 0

func _ready() -> void:
	starting_position = global_position

func kill():
	var body = body_scene.instantiate() as RigidBody2D
	body.global_position = global_position
	body.linear_velocity = Vector2.ZERO

	# Reset player position to start
	global_position = starting_position
	velocity = Vector2.ZERO
	
	bodies_to_spawn.push_back(body)
	body_cooldown = 3

func _physics_process(delta):
	if body_cooldown <= 0 and not bodies_to_spawn.is_empty():
		var body = bodies_to_spawn.pop_back()
		get_tree().current_scene.add_child(body)
	else:
		body_cooldown -= 1
		print(body_cooldown)
		
	
	# Add the gravity.
	if not is_on_floor():
		velocity.y += gravity * delta

	# Handle jump.
	if Input.is_action_just_pressed("jump") and is_on_floor():
		velocity.y = JUMP_VELOCITY

	# Get the input direction and handle the movement/deceleration.
	var direction = Input.get_axis("left", "right")
	if direction == 0:
		pass
		#direction = Input.get_axis("left", "right") # Arrow keys
	if direction != 0:
		velocity.x = direction * SPEED
	else:
		velocity.x = move_toward(velocity.x, 0, SPEED)

	move_and_slide()
