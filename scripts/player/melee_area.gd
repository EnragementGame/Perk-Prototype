extends Area3D

var camera : Camera3D
var hit_detection : CollisionShape3D

func _ready() -> void:
	camera = get_parent()
	hit_detection = get_child(0)

func melee(weapon : Weapon):
	hit_detection.shape.size = Vector3(weapon.hit_width, weapon.hit_hight, weapon.weapon_range)
	hit_detection.position = weapon.area_offset
	if has_overlapping_bodies():
		var hit_enemies : Array[Node3D] = get_overlapping_bodies()
		for enemy in hit_enemies:
			var space_state = camera.get_world_3d().direct_space_state
			var from = camera.global_position
			var to = enemy.global_position
			var query = PhysicsRayQueryParameters3D.create(from, to, 0b0110)
			var results = space_state.intersect_ray(query)
			if results.get("collider") == enemy:
				enemy.get_node("HealthManager").take_damage(weapon.damage, self)
