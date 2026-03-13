extends Control

@export var perk_manager : PerkManager
@export var health_manager : HealthManager
@export var item_manager : ItemManager

@onready var health_display : Label = %HealthDisplay
@onready var level_display : Label = %LevelDisplay
@onready var gold_display : Label = %GoldDisplay

func _process(delta: float) -> void:
	health_display.text = "Health:" + str(health_manager.health)
	level_display.text = "Level:" + str(perk_manager.level) + " | Exp:" + str(perk_manager.exp)
	gold_display.text = "Gold:" + str(item_manager.gold)
