class_name WeaponStats extends Resource

enum Weapon_Type {
	Gun,
	Melee,
	Cooldown,
	Misc
}

@export_category("Universal Stats")
@export var damage : int
@export var attack_speed : float
@export var range : float
@export var proc_multiplier : float
@export var weapon_type : Weapon_Type
@export_category("Gun Stats")
@export var reload_speed : float
@export var bullet_count : int
@export var spread : float
@export var ammo : int
@export_category("Melee Stats")
@export var hit_hight : float
@export var hit_width : float
@export var area_offset : Vector3
