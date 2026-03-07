extends CharacterBody3D

@export_category("Camera")
@export var sensitivity : float
@onready var camera  : Node3D = %Camera
var cam_limit : float = 89

var stats_manager : StatsManager
@export_category("Movement")
@export var gravity : float
@export var ground_drag : float
@export var air_drag : float
var drag

func _ready() -> void:
	if has_node("StatsManager"):
		stats_manager = get_node("StatsManager")
	else:
		push_warning("Required node of type:StatsManager required, script may not function properly")
		return
	Input.mouse_mode = Input.MOUSE_MODE_CAPTURED

func _input(event: InputEvent) -> void:
	if event is InputEventMouseMotion:
		rotate_y(-deg_to_rad(event.relative.x * sensitivity))
		camera.rotate_x(-deg_to_rad(event.relative.y * sensitivity))
		camera.rotation.x = clamp(camera.rotation.x, deg_to_rad(-cam_limit), deg_to_rad(cam_limit))

func _physics_process(delta: float) -> void:
	if !is_on_floor():
		velocity += Vector3(0,-gravity * delta, 0)
		drag = air_drag
	else:
		drag = ground_drag

	if Input.is_action_just_pressed("Jump") and is_on_floor():
		velocity.y = stats_manager.jump_height

	var input_dir := Input.get_vector("Left", "Right", "Forward", "Backward")
	var direction := (transform.basis * Vector3(input_dir.x, 0, input_dir.y)).normalized()
	if direction:
		velocity.x = direction.x * stats_manager.speed
		velocity.z = direction.z * stats_manager.speed
	else:
		velocity.x = lerp(velocity.x, 0.0, (drag * 0.1))
		velocity.z = lerp(velocity.z, 0.0, (drag * 0.1))

	move_and_slide()
