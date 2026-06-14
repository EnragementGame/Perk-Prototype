class_name ItemInteractable extends Component

var interactable : Interactable
var item_data_handler : ItemDataHandler

func _ready() -> void:
	interactable = get_component("Interactable")
	item_data_handler = get_component("ItemDataHandler")
	interactable.interacted.connect(pickup_item)
	
func pickup_item(reciever : Node3D):
	if reciever.has_node("ItemManager"):
		var item_manager : ItemManager = reciever.get_node("ItemManager")
		if item_manager.has_node(str(item_data_handler.item_id)):
			item_manager.get_node(str(item_data_handler.item_id)).count += 1
		else:
			var item_node : Item = Item.new()
			item_node.set_script(item_data_handler.item_script)
			item_node.name = item_data_handler.item_script.get_global_name()
			item_manager.add_child(item_node)
			item_node.item_manager = item_manager
			item_node.count += 1
			item_node.on_pickup()
			print(item_node.name + "|" + item_node.get_parent().name)
	get_parent().queue_free()
