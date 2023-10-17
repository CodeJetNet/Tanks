extends CharacterBody2D

@export var speed = 200
var bulletz = preload("res://bullet.tscn")
const SPEED = 300.0
const JUMP_VELOCITY = -400.0
@export var muzzle_velocity = 350

# Get the gravity from the project settings to be synced with RigidBody nodes.
var gravity = ProjectSettings.get_setting("physics/2d/default_gravity")

func get_input():
	look_at(get_global_mouse_position())
	
	var dir = Input.get_axis("back", "forward")
	velocity = transform.x * dir * speed
	if Input.is_action_just_pressed("shoot"):
		shoot()

func shoot():
	var b = bulletz.instantiate()
	owner.add_child(b)
	b.transform = $Gun.global_transform
	b.velocity = b.transform.x * muzzle_velocity
	b.gravity = gravity

func _physics_process(delta):
	get_input()
	# Add the gravity.
	if not is_on_floor():
		velocity.y += gravity * delta

	# Handle Jump.
	if Input.is_action_just_pressed("ui_accept") and is_on_floor():
		velocity.y = JUMP_VELOCITY

	# Get the input direction and handle the movement/deceleration.
	# As good practice, you should replace UI actions with custom gameplay actions.
	var direction = Input.get_axis("ui_left", "ui_right")
	if direction:
		velocity.x = direction * SPEED
	else:
		velocity.x = move_toward(velocity.x, 0, SPEED)

	move_and_slide()
