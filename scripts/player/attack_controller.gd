extends Node

@export var weapon_manager : WeaponManager

@onready var shoot_point : Node3D = %ShootPoint
@onready var melee_area : Area3D = %MeleeArea

var weapon : Weapon

@onready var camera : Camera3D = %Camera
var attack_cooldown : float
@export var player : Node3D

func _ready() -> void:
	camera = get_parent()
	weapon_manager.weapon_swapped.connect(set_weapon)

func _process(delta: float) -> void:
	weapon.weapon_model.global_position = camera.global_position
	weapon.weapon_model.rotation = Vector3(camera.rotation.x, player.rotation.y, 0)
	
	if attack_cooldown > 0:
		attack_cooldown -= delta
	if Input.is_action_just_pressed("Shoot") && attack_cooldown <= 0:
		match weapon.weapon_type:
			0:
				if !weapon.reloading:
					if weapon.ammo > 0:
						shoot_point.shoot(weapon)
						weapon.ammo -= 1
					else:
						weapon_manager.reload(weapon_manager.active_weapon)
			1:
				melee_area.melee(weapon)
		attack_cooldown = weapon.attack_speed

func set_weapon():
	weapon = weapon_manager.weapons[weapon_manager.active_weapon]
	attack_cooldown = 0
