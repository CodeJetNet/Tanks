extends CharacterBody2D

@export var speed = 200
var bulletz = preload("res://bullet.tscn")
const SPEED = 300.0
@export var muzzle_velocity = 900
@onready var line = $Gun/Gun/Line2D
@onready var weapon_velocity = $HScrollBar
@onready var weapon_vector = $VScrollBar

# Get the gravity from the project settings to be synced with RigidBody nodes.
var gravity = ProjectSettings.get_setting("physics/2d/default_gravity")

func get_input():
	if Input.is_action_just_pressed("shoot"):
		shoot()

func shoot():
	print(weapon_velocity.value)
	var b = bulletz.instantiate()
	owner.add_child(b)
	b.transform = $Gun/Gun.global_transform
	b.velocity = b.transform.x * weapon_velocity.value * 50
	b.gravity = gravity

func _physics_process(delta):
	get_input()
	move_and_slide()
