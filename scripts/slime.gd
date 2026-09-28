extends Node2D

@onready var encouner: Area2D = %Encouner

@onready var animated_sprite_2d: AnimatedSprite2D = $AnimatedSprite2D

@onready var ray_cast_left: RayCast2D = $RayCast_left
@onready var ray_cast_right: RayCast2D = $RayCast_right

const SPEED = 60
var direction = 1
var global_delta = 1
var can_move_slime : bool = true

func _moving_slime():
	if ray_cast_left.is_colliding():
		direction = 1
		animated_sprite_2d.flip_h = true
	elif ray_cast_right.is_colliding():
		direction = -1
		animated_sprite_2d.flip_h = false
	position.x += direction * SPEED * global_delta
# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	global_delta = delta
	if can_move_slime == true:
		_moving_slime()
