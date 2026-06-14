class_name ItemDataHandler extends Component

@export var test : ItemData
var interactable : Interactable
var item_id : StringName
var mesh : MeshInstance3D
var item_script : Script

func _ready() -> void:
	interactable = get_component("Interactable")
	mesh = get_parent().get_node("ItemMesh")
	load_item(test)

func load_item(item : ItemData):
	item_id = item.item_id
	mesh.mesh = item.item_model
	item_script = item.item_component
