extends CharacterBody2D

const SPEED = 200.0
const JUMP_VELOCITY = -400.0
const BODY_SPAWN_OFFSET = Vector2(0, -10)

var body_scene = preload("res://scenes/player/Body.tscn")
var gravity = ProjectSettings.get_setting("physics/2d/default_gravity")
var starting_position = Vector2.ZERO

func _ready() -> void:
	starting_position = global_position

func _spawn_box():
	if LevelManager.use_clone():
		var body = body_scene.instantiate()
		body.global_position = global_position + BODY_SPAWN_OFFSET
		body.linear_velocity = velocity

		# Reset player position to start
		global_position = starting_position
		velocity = Vector2.ZERO

		get_tree().current_scene.add_child(body)

func _physics_process(delta):
	# Add the gravity.
	if not is_on_floor():
		velocity.y += gravity * delta

	# Handle jump.
	if Input.is_action_just_pressed("ui_accept") and is_on_floor():
		velocity.y = JUMP_VELOCITY

	# Spawn box on N key
	if Input.is_action_just_pressed("spawn_box"):
		_spawn_box()

	# Get the input direction and handle the movement/deceleration.
	var direction = Input.get_axis("ui_left", "ui_right")
	if direction == 0:
		direction = Input.get_axis("left", "right") # Arrow keys
	if direction != 0:
		velocity.x = direction * SPEED
	else:
		velocity.x = move_toward(velocity.x, 0, SPEED)

	move_and_slide()
