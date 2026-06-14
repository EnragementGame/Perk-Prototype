class_name ItemDataHandler extends Component

@export var test : ItemData
var interactable : Interactable
var item_id : StringName
var mesh : MeshInstance3D
var item_script : Script
var item_count : int ##The amount of item stacks to give to the player. Can be negative to remove stacks from picking it up.

func _ready() -> void:
	interactable = get_component("Interactable")
	mesh = get_parent().get_node("ItemMesh")
	load_item(test, 1)

func load_item(item : ItemData, amount : int):
	item_id = item.item_id
	mesh.mesh = item.item_model
	item_script = item.item_component
	item_count = amount
