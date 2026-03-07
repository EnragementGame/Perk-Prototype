class_name WeaponManager extends Component

signal weapon_swapped()

var stats_manager : StatsManager

var active_weapon : int
var weapons : Dictionary[int, Weapon]

func _ready() -> void:
	stats_manager = get_component("StatsManager")
	for child in get_children().size():
		weapons[child] = get_component_in_child("Weapon", child)
		weapons[child].reloading = false
	active_weapon = 0
	weapon_swapped.emit()
	print(weapons)

func _process(delta: float) -> void:
	if Input.is_action_just_pressed("WepnHotkeyOne"):
		swap_weapons(0)
	if Input.is_action_just_pressed("WepnHotkeyTwo"):
		swap_weapons(1)
	if Input.is_action_just_pressed("WepnHotkeyThr"):
		swap_weapons(2)
	
	if Input.is_action_just_pressed("Reload"):
		reload(active_weapon)

func swap_weapons(weapon : int):
	active_weapon = weapon
	weapons[active_weapon].weapon_model.visible = true
	weapon_swapped.emit()
	for i in weapons.size():
		if i != active_weapon:
			reload(i)
			set_visablility(i)

func reload(weapon_number : int):
	if weapons[weapon_number].reloading || weapons[weapon_number].base_stats.weapon_type != 0:
		return
	weapons[weapon_number].reloading = true
	await get_tree().create_timer(weapons[weapon_number].reload_speed).timeout
	weapons[weapon_number].ammo = weapons[weapon_number].max_ammo
	weapons[weapon_number].reloading = false

func set_visablility(weapon_number : int):
	weapons[weapon_number].weapon_model.visible = false
