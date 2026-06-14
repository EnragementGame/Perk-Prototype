class_name Prefab extends Component

var footprint : Area3D
var obstructed : bool

func _ready() -> void:
	footprint = get_parent().get_node("Footprint")
