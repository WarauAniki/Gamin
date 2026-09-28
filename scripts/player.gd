extends CharacterBody2D
 
@onready var animated_sprite: AnimatedSprite2D = $AnimatedSprite2D
@onready var player_camera: Camera2D = $Camera2D


const SPEED = 150.0
const JUMP_VELOCITY = -300.0

var global_delta = 0
var can_move_player : bool = true

func  _move() -> void:
	# GO_INTO_BATTLE scene. Need to turn off player camera. Got gravity in move_and_slide()
	if can_move_player == false:
		move_and_slide()
		player_camera.enabled = false
	else:
	# Add the gravity.
		if not is_on_floor():
			velocity += get_gravity() * global_delta
			animated_sprite.play("jump")
	
		# Handle jump.
		if Input.is_action_just_pressed("ui_accept") and is_on_floor():
			velocity.y = JUMP_VELOCITY
	
		# Get the input direction and handle the movement/deceleration.
		# As good practice, you should replace UI actions with custom gameplay actions.
		var direction := Input.get_axis("ui_left", "ui_right")
		if direction:
			velocity.x = direction * SPEED
			animated_sprite.play("walk")
		else:
			velocity.x = move_toward(velocity.x, 0, SPEED)
			animated_sprite.play("idle")
		if direction > 0: 
			animated_sprite.flip_h = false
		if direction < 0: 
			animated_sprite.flip_h = true
	
		move_and_slide()


func _physics_process(delta: float) -> void:
	global_delta = delta
#	if get_tree().current_scene.name == "Game":

	_move()
	# PUT EVERYTHING INTO NEW FUNC AND CALL IT FROM THE OPEN_WORLD SCENE
	# ELSE YOU NEED KINDA NEW PHYSICS FOR BUTTLE_SCENE
