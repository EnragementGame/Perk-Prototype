class_name MovementManager extends Node

var velocity : Vector3
var move_direction : Vector3

@export_category("Movement Stats")
@export var acceleration : float
@export var gravity : float
@export var speed_limit : float
@export var fall_limit : float
@export var drag : float
@export var air_drag : float

var can_move : bool
var grounded : bool
var jumping : bool
var has_gravity : bool

var agent : Node3D

func _ready() -> void:
	pass # Replace with function body.

func _process(delta: float) -> void:
	print(velocity)
	move(delta)
	apply_gravity(delta)

func move(_delta : float):
	if can_move:
		if move_direction:
			velocity.x = move_toward(velocity.x, move_direction.x * speed_limit, acceleration * _delta)
			velocity.z = move_toward(velocity.z, move_direction.z * speed_limit, acceleration * _delta)
		else:
			velocity.x = move_toward(velocity.x, 0, drag * _delta)
			velocity.z = move_toward(velocity.z, 0, drag * _delta)
		agent.position += velocity

func apply_knockback(direction : Vector3, strength : Vector3):
	velocity = direction * strength
	
func apply_gravity(_delta : float):
	if has_gravity && !jumping:
		if grounded:
			velocity.y = 0
		elif velocity.y > -fall_limit:
			velocity.y -= gravity * _delta
			
