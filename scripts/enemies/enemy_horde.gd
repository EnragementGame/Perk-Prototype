extends CharacterBody3D

var player_tracker : PlayerTracker
var stats_manager : StatsManager

var speed : float
@export var climb_speed : float
@export var gravity : float
var climbing : bool = false

@onready var climb_check : Area3D = %ClimbCheck

func _ready() -> void:
	player_tracker = get_node("PlayerTracker")
	stats_manager = get_node("StatsManager")
	speed = randf_range(stats_manager.speed * 0.8, stats_manager.speed * 1.2)

func _physics_process(delta: float) -> void:
	if climb_check.has_overlapping_bodies():
		climbing = true
	else:
		climbing = false
	
	if !is_on_floor() && !climbing:
		velocity += Vector3(0,-gravity * delta, 0)
	
	move_enemy()
	
	move_and_slide()

func move_enemy():
	velocity.x = (-basis.z * speed).x
	velocity.z = (-basis.z * speed).z
	if climbing:
		velocity.y = climb_speed
	look_at(player_tracker.player.global_position)
	rotation = Vector3(0, rotation.y, 0)
