class_name HealthManager extends Component

signal hurt(entity : Node3D, damage_dealer : Node3D)
signal heal(entity : Node3D, healer : Node3D)
signal death(entity : Node3D, killer : Node3D)

var stats_manager : StatsManager

var health : int
var has_osp : bool
var osp_threshold : int
var can_take_damage : bool = true

func _ready() -> void:
	stats_manager = get_component("StatsManager")
	health = stats_manager.health
	print(stats_manager)

func take_damage(damage : int, dealer : Node3D):
	if !can_take_damage:
		return
	health -= damage
	print(health)
	if health <= 0:
		die(dealer)
		return
	hurt.emit(get_parent(), dealer)
	
func heal_health(heal_amount : int, healer : Node3D):
	health += heal_amount
	if health > stats_manager.health:
		health = stats_manager.health
	heal.emit(get_parent(), healer)
	
func die(killer : Node3D):
	can_take_damage = false
	death.emit(get_parent(), killer)
