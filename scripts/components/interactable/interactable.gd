class_name Interactable extends Component

signal interacted(interactie : Node3D)

@export var uses : int

func interact(interactie : Node3D):
	print("Interacted with:" + get_parent().name)
	interacted.emit(interactie)
