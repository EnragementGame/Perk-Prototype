class_name ExpItem extends Item

var perk_manager : PerkManager

func on_pickup():
	perk_manager = item_manager.perk_manager
	perk_manager.gained_exp.connect(gain_bonus_exp)

func gain_bonus_exp(amount : int) -> void:
	var bonus_exp : float = amount * (0.08 * count)
	perk_manager.gain_exp(roundi(bonus_exp + 0.25), false)
