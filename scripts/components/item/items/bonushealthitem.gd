class_name BonusHealthItem extends Item

var stat_manager : StatsManager

func on_pickup(amount : int):
	if !stat_manager:
		stat_manager = item_manager.stats_manager
	update_health(amount)

func update_health(amount : int):
	stat_manager.bonus_health += 50 * amount
	stat_manager.recalculate_health()
