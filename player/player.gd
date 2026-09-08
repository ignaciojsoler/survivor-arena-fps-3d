extends CharacterBody3D

const MOUSE_SEN = 0.5
const MIN_CLAMP = -60
const MAX_CLAMP = 60

func _ready():
	# Hide the mouse cursor when the game starts
	Input.mouse_mode = Input.MOUSE_MODE_HIDDEN

func _unhandled_input(event: InputEvent) -> void:
	# Handle mouse movement
	if event is InputEventMouseMotion:
		# Rotate the player left/right
		# event.relative.x is the horizontal mouse movement
		self.rotation_degrees.y -= event.relative.x * MOUSE_SEN
		
		# Rotate the camera up/down
		# event.relative.y is the vertical mouse movement
		%Camera3D.rotation_degrees.x -= event.relative.y * MOUSE_SEN
		
		# Prevent the camera from rotating too far up/down
		%Camera3D.rotation_degrees.x = clamp(
			%Camera3D.rotation_degrees.x,
			MIN_CLAMP,
			MAX_CLAMP
		)

	# Pressing Escape toggles the mouse cursor
	elif event.is_action_pressed("ui_cancel"):
		var is_hidden = Input.mouse_mode == Input.MOUSE_MODE_HIDDEN
		
		if is_hidden:
			Input.mouse_mode = Input.MOUSE_MODE_VISIBLE
		else:
			Input.mouse_mode = Input.MOUSE_MODE_HIDDEN

func _physics_process(delta: float) -> void:
	const SPEED = 12
	
	# Get keyboard input as a 2D direction
	# X = left/right, Y = forward/backward
	var input_direction_2d = Input.get_vector(
		"ui_left", "ui_right", "ui_up", "ui_down"
	)
	
	# Convert the 2D input into a 3D direction
	# Y is 0 because we don't want vertical movement
	var input_direction_3d = Vector3(
		input_direction_2d.x,
		0.0,
		input_direction_2d.y
	)
	
	# Make the direction relative to the player's rotation
	var direction = transform.basis * input_direction_3d
	
	# Set horizontal movement speed
	velocity.x = direction.x * SPEED
	velocity.z = direction.z * SPEED
	
	const GRAVITY = 20
	velocity.y -= GRAVITY * delta
	
	if Input.is_action_just_pressed("ui_accept") and is_on_floor():
		velocity.y = 10.00
	elif Input.is_action_just_released("ui_accept") and velocity.y > 0:
		velocity.y = 0.0
	
	# Move the character and handle collisions
	move_and_slide()
