class_name PlayerInput extends Node

var input_direction = Vector2.ZERO
var input_jump = 0

# Called when the node enters the scene tree for the first time.
func _ready():
	NetworkTime.before_tick_loop.connect(_gather)
	
	if get_multiplayer_authority() != multiplayer.get_unique_id():
		set_process(false)
		set_physics_process(false)
	
	input_direction = Input.get_axis("move_left", "move_right")

func _gather():
	if not is_multiplayer_authority():
		return
		
	input_direction = Input.get_axis("move_left", "move_right")

func _process(delta):
	input_jump = Input.get_action_strength("jump")
