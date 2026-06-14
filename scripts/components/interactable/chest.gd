class_name Chest extends Component

var interactable : Interactable
@export var item : PackedScene

func _ready() -> void:
	interactable = get_component("Interactable")
	interactable.interacted.connect(roll_item)

func roll_item(): ##Roll for a random item
	var item_data : ItemData
	var spawned_item : Node3D = item.instantiate()
	spawned_item.get_node("ItemDataHandler").load_item(item_data)
	get_parent().queue_free()
