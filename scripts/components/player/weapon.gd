class_name Weapon extends Component

@export var base_stats : WeaponStats
@export var weapon_model : Node3D
var weapon_type : int

var damage : int
var attack_speed : float
var weapon_range : float
var proc_multiplier : float

var reload_speed : float
var reloading : bool
var reload_timer : float
var bullet_count : int
var spread : float
var max_ammo : int
var ammo : int

var hit_hight : float
var hit_width : float
var area_offset : Vector3

func _ready() -> void:
	weapon_type = base_stats.weapon_type
	damage = base_stats.damage
	attack_speed = base_stats.attack_speed
	weapon_range = base_stats.range
	proc_multiplier = base_stats.proc_multiplier
	
	match weapon_type:
		0:
			reload_speed = base_stats.reload_speed
			reloading = false
			bullet_count = base_stats.bullet_count
			spread = base_stats.spread
			max_ammo = base_stats.ammo
			ammo = max_ammo
		1:
			hit_hight = base_stats.hit_hight
			hit_width = base_stats.hit_width
			area_offset = base_stats.area_offset
