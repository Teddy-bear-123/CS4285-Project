extends CharacterBody2D

# --- Movement ---
@export var max_speed := 220.0
@export var acceleration := 1200.0
@export var deceleration := 1600.0
@export var air_control := 0.5

# --- Jump ---
@export var jump_force := 420.0
@export var gravity := 1200.0
@export var jump_cut_multiplier := 0.5

# --- Forgiveness ---
@export var coyote_time := 0.1
@export var jump_buffer := 0.1

var coyote_timer := 0.0
var jump_buffer_timer := 0.0

func _physics_process(delta):
	apply_gravity(delta)
	handle_horizontal(delta)
	handle_jump(delta)
	move_and_slide()

func apply_gravity(delta):
	if not is_on_floor():
		velocity.y += gravity * delta
	else:
		coyote_timer = coyote_time

func handle_horizontal(delta):
	var input := Input.get_axis("move_left", "move_right")
	var target_speed := input * max_speed

	var accel := acceleration
	if not is_on_floor():
		accel *= air_control

	if abs(target_speed) > 0.01:
		velocity.x = move_toward(velocity.x, target_speed, accel * delta)
	else:
		velocity.x = move_toward(velocity.x, 0, deceleration * delta)

func handle_jump(delta):
	# Timers
	coyote_timer -= delta
	jump_buffer_timer -= delta

	if Input.is_action_just_pressed("jump"):
		jump_buffer_timer = jump_buffer

	if jump_buffer_timer > 0 and coyote_timer > 0:
		velocity.y = -jump_force
		jump_buffer_timer = 0
		coyote_timer = 0

	# Variable jump height
	if Input.is_action_just_released("jump") and velocity.y < 0:
		velocity.y *= jump_cut_multiplier

func _ready():
	collision_layer = 1  # Binary: 0b00001
	collision_mask = 2   # Binary: 0b00010
	InputMap.load_from_project_settings()
