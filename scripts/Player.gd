extends CharacterBody2D

const SPEED = 200.0
const JUMP_VELOCITY = -400.0
const BOX_SIZE = Vector2(32, 32) # Match player size
const BOX_COLOR = Color(0.2, 0.6, 1.0, 1)
const BOX_SPAWN_OFFSET = Vector2(0, 32)

# Get the gravity from the project settings to be synced with RigidBody nodes.
var gravity = ProjectSettings.get_setting("physics/2d/default_gravity")

func _spawn_box():
	var box = RigidBody2D.new()
	box.position = global_position + BOX_SPAWN_OFFSET
	box.linear_velocity = velocity # Give box current player velocity
	var shape = RectangleShape2D.new()
	shape.size = BOX_SIZE
	var collision = CollisionShape2D.new()
	collision.shape = shape
	box.add_child(collision)
	var rect = ColorRect.new()
	rect.color = BOX_COLOR
	rect.anchor_left = 0.5
	rect.anchor_top = 0.5
	rect.anchor_right = 0.5
	rect.anchor_bottom = 0.5
	rect.offset_left = -BOX_SIZE.x/2
	rect.offset_top = -BOX_SIZE.y/2
	rect.offset_right = BOX_SIZE.x/2
	rect.offset_bottom = BOX_SIZE.y/2
	box.add_child(rect)
	get_tree().current_scene.add_child(box)
	# Reset player position to start
	global_position = Vector2(400, 500)
	velocity = Vector2.ZERO

func _physics_process(delta):
	# Add the gravity.
	if not is_on_floor():
		velocity.y += gravity * delta

	# Handle jump.
	if Input.is_action_just_pressed("ui_accept") and is_on_floor():
		velocity.y = JUMP_VELOCITY

	# Spawn box on Enter key
	if Input.is_action_just_pressed("ui_accept"):
		_spawn_box()

	# Get the input direction and handle the movement/deceleration.
	var direction = Input.get_axis("ui_left", "ui_right")
	if direction != 0:
		velocity.x = direction * SPEED
	else:
		velocity.x = move_toward(velocity.x, 0, SPEED)

	move_and_slide()
