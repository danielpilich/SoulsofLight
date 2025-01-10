extends CharacterBody2D

@export var speed = 900

var gravity = ProjectSettings.get_setting("physics/2d/default_gravity")
var direction: Vector2 = Vector2.LEFT

@onready var animation_tree = $AnimationTree
@onready var ray_cast_right: RayCast2D = $RayCastRight
@onready var ray_cast_left: RayCast2D = $RayCastLeft
@onready var state_machine: StateMachine = $StateMachine
@onready var sprite_2d: Sprite2D = $Sprite2D


func _ready():
	animation_tree.active = true

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _physics_process(delta):
	
	if not is_on_floor():
		velocity.y += gravity + delta
	
	if ray_cast_right.is_colliding():
		direction.x = -1
	if ray_cast_left.is_colliding():
		direction.x = 1

	if direction.x > 0:
		sprite_2d.scale.x = -1
	elif direction.x < 0:
		sprite_2d.scale.x = 1

	if direction and state_machine.check_if_can_move():
		velocity.x = direction.x * speed * delta
	else:
		velocity.x = move_toward(velocity.x, 0, speed * delta)

	move_and_slide()
