class_name PlayerTracker extends Component

var player : Node3D
var player_direction : Vector3
var player_distance : float

func _process(delta: float) -> void:
	if !player:
		return
	player_direction = -(get_parent().global_position - player.global_position)
	player_distance = player_direction.length()
