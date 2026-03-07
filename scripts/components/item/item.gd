class_name Item extends Component

var item_manager : ItemManager

var count : int
var tier : int 

func on_pickup():
	if !item_manager:
		item_manager = get_parent_component()
		count = 1
	else:
		increase_stack(1)

func increase_stack(amount : int):
	count += amount
