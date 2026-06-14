extends Node3D

@export var enemies : Dictionary[StringName, SpawnData]
@export var prefabs : Array[PackedScene]
var spawned_prefabs : Array[Node3D]
@export var spawn_area : Vector2
@export var player : Node3D
@onready var level : Node = %Level
var enemies_alive : int

var max_prefabs : int
var spawn_credits : int
var item_credits : int

func _ready() -> void:
	prepare_map()

func _process(delta: float) -> void:
	if Input.is_action_just_pressed("DebugKeyOne"):
		spawn_enemy()
	
func prepare_map():
	for prefabs in spawned_prefabs:
		prefabs.queue_free()
	spawned_prefabs.clear()
	max_prefabs = randi_range(7, 12)
	for i in max_prefabs:
		var spawn_start : Vector3 = get_random_map_pos()
		var prefab : Node3D
		var prefab_id : int = randi_range(0, prefabs.size() - 1)
		var ray_end : Vector3 = spawn_ray(spawn_start).get("position")
		prefab = prefabs[prefab_id].instantiate()
		level.add_child(prefab)
		spawned_prefabs.append(prefab)
		prefab.position = ray_end
		prefab.rotation.y = randf_range(0,4)
	prefab_overlap_check()

func prefab_overlap_check():
	print("Redoing placement check")
	for prefab in spawned_prefabs:
		var prefab_footprint : Prefab = prefab.get_node("Prefab")
		var replace_check_limit : int
		print("Starting check for: " + prefab.name)
		print(prefab_footprint.obstructed)
		while prefab_footprint.obstructed && replace_check_limit < 5:
				print(prefab.name + " has overlap, replacing")
				var replace_start : Vector3 = get_random_map_pos()
				var ray_end : Vector3 = spawn_ray(replace_start).get("position")
				prefab.position = ray_end
				replace_check_limit += 1
		if replace_check_limit >= 5:
			print("Prefab check failed too many times, deleting prefab")
			prefab.queue_free()


func spawn_interactables():
	var spawn_start = get_random_map_pos()

func spawn_enemy():
	var cost : int
	var spawn_roll : int = randi_range(1, 100)
	var spawn_start = get_random_map_pos()
	print(spawn_start)
	var horde_size : int = randi_range(enemies["Horde"].spawn_min,  enemies["Horde"].spawn_max)
	cost = enemies["Horde"].spawn_value * horde_size
	var ray_end : Dictionary = spawn_ray(spawn_start)
	while spawn_ray(spawn_start).get("position").distance_to(player.global_position) < 3:
		spawn_start = get_random_map_pos()
		ray_end = spawn_ray(spawn_start)
	for i in horde_size:
		var last_enemy : Node3D
		var spawned_enemy : Node3D
		var spawn_position : Vector3 = Vector3(randf_range(ray_end.get("position").x + 3, ray_end.get("position").x -3), 
		ray_end.get("position").y + 0.05, randf_range(ray_end.get("position").z + 3, ray_end.get("position").z -3))
		spawned_enemy = enemies["Horde"].enemy_scene.instantiate()
		spawned_enemy.get_node("PlayerTracker").player = player
		spawned_enemy.get_node("HealthManager").death.connect(remove_enemy)
		add_child(spawned_enemy)
		enemies_alive += 1
		spawned_enemy.position = spawn_position
		last_enemy = spawned_enemy
	
	print(enemies_alive)
	spawn_credits -= cost

func remove_enemy(enemy : Node3D, killer : Node3D):
	enemy.queue_free()
	enemies_alive -= 1
	print(enemies_alive)

func spawn_ray(start_pos : Vector3) -> Dictionary:
	var space_state = get_world_3d().direct_space_state
	var from = start_pos
	var forward = Vector3.DOWN * 60
	var to = from + forward 
	var query = PhysicsRayQueryParameters3D.create(from, to, 0b0111)
	var results = space_state.intersect_ray(query)
	return results

func get_random_map_pos() -> Vector3:
	return Vector3(randf_range(spawn_area.x,-spawn_area.x), 50, randf_range(spawn_area.y,-spawn_area.y))
	
