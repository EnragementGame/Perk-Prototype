class_name StatsManager extends Component

signal updated_health(old_value : int, new_value : int)

@export_category("Base Stats")
@export var base_stats : Stats

var speed : float
var jump_height : float
var jumps : int

var health : int
var health_multiplier : int
var bonus_health : int
var max_health

var damage : int
var attack_speed : float

func _ready() -> void:
	speed = base_stats.speed
	jump_height = base_stats.jump_height
	jumps = base_stats.jumps
	health_multiplier = 1
	health = base_stats.health
	max_health = health
	damage = base_stats.damage
	attack_speed = base_stats.attack_speed

func recalculate_health():
	var old_max_health : int = max_health
	max_health = (health * health_multiplier) + bonus_health
	print(max_health)
	updated_health.emit(old_max_health, max_health)
