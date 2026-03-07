extends StaticBody3D

@export_category("Camera")
@export var sensitivity : float
@onready var camera  : Node3D = %Camera
var cam_limit : float = 89

var movement_manager : MovementManager
var stats_manager : StatsManager
@onready var floor_detection : Area3D = %FloorDetection
var jump_count : int
var jump_position : float

func _ready() -> void:
	if has_node("MovementManager"):
		movement_manager = get_node("MovementManager")
		movement_manager.agent = self
		movement_manager.has_gravity = true
		movement_manager.can_move = true
		movement_manager.grounded = false
	else:
		push_warning("Required node of type:MovementManager required, script may not function properly")
		return
	if has_node("StatsManager"):
		stats_manager = get_node("StatsManager")
		movement_manager.acceleration = stats_manager.speed
		movement_manager.speed_limit = stats_manager.top_speed
		print("speed:" + str(movement_manager.acceleration) + " , top speed:" + str(movement_manager.speed_limit))
		jump_count = stats_manager.jumps
	else:
		push_warning("Required node of type:StatsManager required, script may not function properly")
		return
	Input.mouse_mode = Input.MOUSE_MODE_CAPTURED

func _input(event: InputEvent) -> void:
	if event is InputEventMouseMotion && movement_manager.can_move:
		rotate_y(-deg_to_rad(event.relative.x * sensitivity))
		camera.rotate_x(-deg_to_rad(event.relative.y * sensitivity))
		camera.rotation.x = clamp(camera.rotation.x, deg_to_rad(-cam_limit), deg_to_rad(cam_limit))

func _process(delta: float) -> void:
	if Input.is_action_just_pressed("Jump") && jump_count > 0:
		movement_manager.velocity.y = stats_manager.jump_height
		--jump_count
		jump_position = position.y + stats_manager.jump_height
		movement_manager.jumping = true
	stop_jump()
	var input_dir := Input.get_vector("Left", "Right", "Forward", "Backward")
	movement_manager.move_direction = (transform.basis * Vector3(input_dir.x, 0, input_dir.y)).normalized()
	
	if floor_detection.has_overlapping_bodies() && !movement_manager.jumping:
		movement_manager.grounded = true
		jump_count = stats_manager.jumps
	else:
		movement_manager.grounded = false
		
func stop_jump():
	if position.y >= jump_position:
		movement_manager.jumping = false
