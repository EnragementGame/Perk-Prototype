class_name PerkManager extends Component

signal gained_exp(exp_gained : int)
signal leveled_up()

var stats_manager : StatsManager
var weapon_manager : WeaponManager

var level : int
var exp : int
var exp_to_next : int

func _ready() -> void:
	stats_manager = get_component("StatsManager")
	weapon_manager = get_component("WeaponManager")

func level_up(send_signal : bool, reset_exp : bool):
	level += 1
	if send_signal:
		leveled_up.emit()
	if reset_exp:
		exp -= exp_to_next
	exp_to_next = (100 * level) + (level^2)
	
func gain_exp(amount : int, send_signal : bool):
	exp += amount
	if send_signal:
		gained_exp.emit(amount)
	if exp > exp_to_next:
		level_up(true, true)
