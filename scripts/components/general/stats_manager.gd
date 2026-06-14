class_name StatsManager extends Component

signal updated_stats

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
	max_health = (base_stats.health * health_multiplier) + bonus_health
	damage = base_stats.damage
	attack_speed = base_stats.attack_speed

func update_stats():
	updated_stats.emit()
