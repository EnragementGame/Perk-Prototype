class_name StatsManager extends Component

signal updates_stats

@export_category("Base Stats")
@export var base_stats : Stats

var speed : float
var jump_height : float
var jumps : int

var health : int
var damage : int
var attack_speed : float

func _ready() -> void:
	speed = base_stats.speed
	jump_height = base_stats.jump_height
	jumps = base_stats.jumps
	health = base_stats.health
	damage = base_stats.damage
	attack_speed = base_stats.attack_speed

func update_stats():
	updates_stats.emit()
