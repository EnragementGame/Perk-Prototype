extends RayCast3D

@export var player : Node3D

func _process(delta: float) -> void:
	if Input.is_action_just_pressed("Interact"):
		if !is_colliding():
			return
		var interacted : Node3D = get_collider()
		if interacted.has_node("Interactable"):
			interacted.get_node("Interactable").interact(player)
