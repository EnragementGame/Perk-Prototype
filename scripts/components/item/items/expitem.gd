class_name ExpItem extends Item

var perk_manager : PerkManager

func on_pickup(amount : int):
	if !perk_manager:
		perk_manager = item_manager.perk_manager
		perk_manager.gained_exp.connect(gain_bonus_exp)

func gain_bonus_exp(amount : int) -> void:
	var bonus_exp : float = amount * (0.08 * count)
	if bonus_exp < count:
		bonus_exp += (count * 0.5)
	print(bonus_exp)
	perk_manager.gain_exp(roundi(bonus_exp), false)
