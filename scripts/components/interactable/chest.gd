extends Component

var interactable : Interactable

func _ready() -> void:
	interactable = get_component("Interactable")
	interactable.interacted.connect(roll_item)

func roll_item(reciever : Node3D):
	pass
