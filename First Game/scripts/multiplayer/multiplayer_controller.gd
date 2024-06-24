extends CharacterBody2D

const SPEED = 130.0
const JUMP_VELOCITY = -300.0

@onready var animated_sprite = $AnimatedSprite2D
@onready var rollback_synchronizer = $RollbackSynchronizer

# Get the gravity from the project settings to be synced with RigidBody nodes.
var gravity = ProjectSettings.get_setting("physics/2d/default_gravity")

var _respawning = false
var alive = true

@export var input: PlayerInput

@export var player_id := 1:
	set(id):
		player_id = id
		input.set_multiplayer_authority(id)

func _ready():	
	if multiplayer.get_unique_id() == player_id:
		$Camera2D.make_current()
	else:
		$Camera2D.enabled = false
	
	rollback_synchronizer.process_settings()

func _apply_animations(delta):
	
	var direction = input.input_direction
	
	# Flip the Sprite
	if direction > 0:
		animated_sprite.flip_h = false
	elif direction < 0:
		animated_sprite.flip_h = true
	
	# Play animations
	if is_on_floor():
		if direction == 0:
			animated_sprite.play("idle")
		else:
			animated_sprite.play("run")
	else:
		animated_sprite.play("jump")

func _rollback_tick(delta, tick, is_fresh):
	if not _respawning:
		_apply_movement_from_input(delta)
	else:
		_respawning = false
		position = MultiplayerManager.respawn_point
		velocity = Vector2.ZERO
		$TickInterpolator.teleport()
		
		await get_tree().create_timer(0.5).timeout
		alive = true

func _apply_movement_from_input(delta):
	
	_force_update_is_on_floor()
	
	# Add the gravity.
	if not is_on_floor():
		velocity.y += gravity * delta
	elif input.input_jump > 0:
		# Handle jump.
		velocity.y = JUMP_VELOCITY * input.input_jump
	
	# Get the input direction: -1, 0, 1
	var direction = input.input_direction
	
	# Apply movement
	if direction:
		velocity.x = direction * SPEED
	else:
		velocity.x = move_toward(velocity.x, 0, SPEED)

	velocity *= NetworkTime.physics_factor
	move_and_slide()
	velocity /= NetworkTime.physics_factor

func _force_update_is_on_floor():
	var old_velocity = velocity
	velocity = Vector2.ZERO
	move_and_slide()
	velocity = old_velocity

func _process(delta):
	if not multiplayer.is_server() || MultiplayerManager.host_mode_enabled:
		_apply_animations(delta)
		
func mark_dead():
	print("Mark player dead!")
	$CollisionShape2D.set_deferred("disabled", true)
	alive = false
	$RespawnTimer.start()

func _respawn():
	print("Respawned!")
	$CollisionShape2D.set_deferred("disabled", false)
	_respawning = true
	
	
















