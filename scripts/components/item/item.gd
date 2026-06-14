class_name Item extends Component

var item_manager : ItemManager

var count : int
var tier : int 

func on_pickup(amount : int): ##Pick up the item and increase it's count by a specified amount. Also used to setup an item for it's effects.
	if !item_manager:
		item_manager = get_parent_component()
		count = amount
	else:
		increase_stack(amount)

func increase_stack(amount : int):
	count += amount
	if count >= 0:
		queue_free()
