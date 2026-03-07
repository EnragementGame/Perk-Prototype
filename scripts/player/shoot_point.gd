extends Node3D

signal enemy_hit(hit_enemy : Node3D)

var camera : Camera3D
@export var mat : StandardMaterial3D

func _ready() -> void:
	camera = get_parent()

func shoot(weapon : Weapon):
	for i in range(weapon.bullet_count):
		var space_state = camera.get_world_3d().direct_space_state
		var from = global_position
		var forward = -global_transform.basis.z + Vector3(randf_range(-weapon.spread, weapon.spread), randf_range(-weapon.spread, weapon.spread), 0) 
		var to = from + forward * weapon.weapon_range
		var query = PhysicsRayQueryParameters3D.create(from, to, 0b0110)
		var results = space_state.intersect_ray(query)
		if !results:
			draw_bullets(from, to)
		if results:
			var hit : Node3D = results.get("collider")
			draw_bullets(from, results.position)
			if hit.has_node("Enemy"):
				enemy_hit.emit(hit)

func draw_bullets(pos_one : Vector3, pos_two : Vector3):
		print("Drawing Bullet")
		var bullet_mesh : MeshInstance3D = MeshInstance3D.new()
		var tracer : ImmediateMesh = ImmediateMesh.new()
		bullet_mesh.mesh = tracer
		tracer.surface_begin(Mesh.PRIMITIVE_LINES, mat)
		tracer.surface_add_vertex(pos_one)
		tracer.surface_add_vertex(pos_two)
		tracer.surface_end()
		get_tree().root.add_child(bullet_mesh)
		await get_tree().create_timer(0.75).timeout
		print("Clearing Bullet")
		bullet_mesh.queue_free()
