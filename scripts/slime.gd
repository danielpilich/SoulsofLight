extends CharacterBody2D

@export var speed = 3000
@export var jump_velocity = -350.0

var gravity = ProjectSettings.get_setting("physics/2d/default_gravity")
var direction: Vector2 = Vector2.LEFT

@onready var animation_tree = $AnimationTree
@onready var ray_cast_right: RayCast2D = $RayCastRight
@onready var ray_cast_left: RayCast2D = $RayCastLeft
@onready var state_machine: StateMachine = $StateMachine
@onready var sprite_2d: Sprite2D = $Sprite2D
@onready var ray_cast_top_right: RayCast2D = $RayCastTopRight
@onready var ray_cast_top_left: RayCast2D = $RayCastTopLeft

func _ready() -> void:
	animation_tree.active = true

func _physics_process(delta):
	# Add the gravity.
	if not is_on_floor():
		velocity.y += gravity * delta

	# Handle jump.
	if (ray_cast_right.is_colliding() or ray_cast_left.is_colliding()) and is_on_floor():
		velocity.y = jump_velocity
		
	if ray_cast_right.is_colliding() and ray_cast_top_right.is_colliding():
		direction.x = -1
	if ray_cast_left.is_colliding() and ray_cast_top_left.is_colliding():
		direction.x = 1

	if direction.x > 0:
		sprite_2d.scale.x = 1
	elif direction.x < 0:
		sprite_2d.scale.x = -1

	if direction and state_machine.check_if_can_move():
		velocity.x = direction.x * speed * delta
	else:
		velocity.x = move_toward(velocity.x, 0, speed * delta)

	move_and_slide()
