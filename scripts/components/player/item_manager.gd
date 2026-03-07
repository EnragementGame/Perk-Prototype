class_name ItemManager extends Component

var gold : int

var stats_manager : StatsManager
var weapon_manager : WeaponManager
var perk_manager : PerkManager

func _ready() -> void:
	stats_manager = get_component("StatsManager")
	weapon_manager = get_component("WeaponManager")
	perk_manager = get_component("PerkManager")

func _process(delta: float) -> void:
	pass

func get_gold(amount : int):
	gold += amount
