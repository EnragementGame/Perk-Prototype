extends Node

@onready var shoot_point : Node3D = %ShootPoint
@onready var melee_area : Area3D = %MeleeArea
@onready var camera : Camera3D = %Camera

var weapon_manager : WeaponManager
var weapon : Weapon

@export var player : Node3D

var attack_cooldown : float

var killstreak : int
var killstreak_timer : float

func _ready() -> void:
	weapon_manager = get_parent().get_node("WeaponManager")
	weapon_manager.weapon_swapped.connect(set_weapon)
	shoot_point.enemy_hit.connect(hit_enemy)
	melee_area.enemy_hit.connect(hit_enemy)

func _process(delta: float) -> void:
	weapon.weapon_model.global_position = camera.global_position
	weapon.weapon_model.rotation = Vector3(camera.rotation.x, player.rotation.y, 0)
	
	if killstreak_timer > 0:
		killstreak_timer -= delta
	else:
		killstreak = 0
	
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

func hit_enemy(enemy : Node3D):
	var enemy_hit : Enemy = enemy.get_node("Enemy")
	var enemy_health : HealthManager = enemy.get_node("HealthManager")
	enemy_health.take_damage(weapon.damage, get_parent())
	if enemy_health.dead:
		if killstreak_timer > 0 || killstreak == 0:
			killstreak += 1
			killstreak_timer = 0.75

func set_weapon():
	weapon = weapon_manager.weapons[weapon_manager.active_weapon]
	attack_cooldown = 0
	
