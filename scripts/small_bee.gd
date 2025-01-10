extends CharacterBody2D

@export var speed = 3000
@export var jump_velocity = -350.0
@export var player: CharacterBody2D
@export var follow_range: float = 500
@export var stop_distance: float = 50
@export var ground_distance: float = 100

var gravity = ProjectSettings.get_setting("physics/2d/default_gravity")
var direction: Vector2 = Vector2.LEFT
var is_dead: bool = false

@onready var animation_tree = $AnimationTree
@onready var state_machine: StateMachine = $StateMachine
@onready var sprite_2d: Sprite2D = $Sprite2D
@onready var ground_ray: RayCast2D = $GroundRay

func _ready() -> void:
	animation_tree.active = true

func _physics_process(delta):
	if is_dead:
		if not is_on_floor():
			velocity.y += gravity * delta
		move_and_slide()
		return
	
	if player:
		var distance_to_player = global_position.distance_to(player.global_position)
		
		if distance_to_player <= follow_range:
			var horizontal_distance = abs(player.global_position.x - global_position.x)
			if horizontal_distance > stop_distance:
				if player.global_position.x > global_position.x:
					direction.x = 1
				elif player.global_position.x < global_position.x:
					direction.x = -1
			else:
				direction.x = 0
		else:
			direction.x = 0
		
		if ground_ray.is_colliding():
			var ground_position = ground_ray.get_collision_point().y
			var desired_y = ground_position - ground_distance
			
			var position_error = desired_y - global_position.y
			
			if abs(position_error) < 2.0:
				velocity.y = 0
			else:
				velocity.y = position_error * 150.0 * delta
		else:
			velocity.y += gravity * delta #no ground, move down
	
	if direction.x > 0:
		sprite_2d.scale.x = -1
	elif direction.x < 0:
		sprite_2d.scale.x = 1

	if direction and state_machine.check_if_can_move():
		velocity.x = direction.x * speed * delta
	else:
		velocity.x = move_toward(velocity.x, 0, speed * delta)

	move_and_slide()


func _on_health_health_depleted() -> void:
	is_dead = true
