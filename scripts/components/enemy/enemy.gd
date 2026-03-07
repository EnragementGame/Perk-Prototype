class_name Enemy extends Component

signal experince(exp : int, send_signel : bool)

var health_manager : HealthManager

var exp_value : int
var gold_value : int

func _ready() -> void:
	health_manager = get_component("HealthManager")
	health_manager.death.connect(send_exp)
	
func send_exp(enemy_killed : Node3D, killer : Node3D):
	experince.emit(exp_value, true)
