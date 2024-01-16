extends CharacterBody3D

@onready var camera_mount = $camera_mount
@onready var animation_player = $visuals/Rogue/AnimationPlayer

var SPEED = 5.0
const JUMP_VELOCITY = 4.5

var walking_speed = 5.0
var running_speed = 8.0

var running = false

var is_locked = false

@export var sens_horizontal = 0.5
@export var sens_vertical = 0.5
@onready var visuals = $visuals

# Get the gravity from the project settings to be synced with RigidBody nodes.
var gravity = ProjectSettings.get_setting("physics/3d/default_gravity")

func _ready():
	Input.mouse_mode = Input.MOUSE_MODE_CAPTURED
	
func _input(event):
	if event is InputEventMouseMotion:
		rotate_y(deg_to_rad(-event.relative.x*sens_horizontal))
		visuals.rotate_y(deg_to_rad(event.relative.y*sens_vertical))
		camera_mount.rotate_x(deg_to_rad(-event.relative.y*sens_vertical))

func _physics_process(delta):
	
	if !animation_player.is_playing():
		is_locked = false
	
	if Input.is_action_just_pressed("hit"):
		if animation_player.current_animation != "hit":
			animation_player.play("1H_Melee_Attack_Stab")
			is_locked = true
	
	if Input.is_action_pressed("run"):
		SPEED = running_speed
		running = true
	else:
		SPEED = walking_speed
		running = false
	
	# Add the gravity.
	if not is_on_floor():
		velocity.y -= gravity * delta

	# Handle jump.
	if Input.is_action_just_pressed("ui_accept") and is_on_floor():
		velocity.y = JUMP_VELOCITY

	# Get the input direction and handle the movement/deceleration.
	# As good practice, you should replace UI actions with custom gameplay actions.
	var input_dir = Input.get_vector("left", "right", "forward", "backward")
	var direction = (transform.basis * Vector3(input_dir.x, 0, input_dir.y)).normalized()
	if direction:
		if !is_locked:
			if running:
				if(animation_player.current_animation != "Running_A"):
					animation_player.play("Running_A")
			else:
				if(animation_player.current_animation != "Running_B"):
					animation_player.play("Running_B")

			visuals.look_at(position + direction)
		
		velocity.x = direction.x * SPEED
		velocity.z = direction.z * SPEED
	else:
		if !is_locked:
			if(animation_player.current_animation != "Idle"):
				animation_player.play("Idle")

		velocity.x = move_toward(velocity.x, 0, SPEED)
		velocity.z = move_toward(velocity.z, 0, SPEED)
	if !is_locked:
		move_and_slide()
