extends CharacterBody2D

@export var SPEED = 130.0
@export var JUMP_VELOCITY = -300.0

# Get the gravity from the project settings to be synced with RigidBody nodes.
var gravity = ProjectSettings.get_setting("physics/2d/default_gravity")
var direction : float

@onready var animated_sprite = $AnimatedSprite2D
@onready var weapon_sprite: AnimatedSprite2D = $HitBox/AnimatedSprite2D
@onready var weapon_animation_player: AnimationPlayer = $HitBox/AnimationPlayer
@onready var weapon: Node2D = $HitBox
@onready var health_node: Health = $Health
@onready var animation_player: AnimationPlayer = $AnimationPlayer
@onready var sprite_2d: Sprite2D = $Sprite2D
@onready var animation_tree: AnimationTree = $AnimationTree
@onready var state_machine: StateMachine = $StateMachine


func _physics_process(delta):
	# Add the gravity.
	if not is_on_floor():
		velocity.y += gravity * delta
	
	# Handle jump.
	#if Input.is_action_just_pressed("jump") and is_on_floor():
		#velocity.y = JUMP_VELOCITY
	
	# Equid/Unequip weapon
	if Input.is_action_just_pressed("equip_weapon"):
		weapon.visible = not weapon.visible
	
	# Get the input direction: -1, 0, 1
	direction = Input.get_axis("move_left", "move_right")
	
	#Flip the Sprite
	if direction > 0:
		sprite_2d.scale.x = 0.75
		if weapon.scale.x < 0:
			weapon_sprite.scale.x *= -1
			weapon.scale.x *= -1
	elif direction < 0:
		sprite_2d.scale.x = -0.75
		if weapon.scale.x > 0:
			weapon_sprite.scale.x *= -1
			weapon.scale.x *= -1
		
	
	#Apply movement
	if direction && state_machine.check_if_can_move():
		velocity.x = direction * SPEED
	else:
		velocity.x = move_toward(velocity.x, 0, SPEED)
	
	move_and_slide()

func update_animation():
	animation_tree.set("parameters/Move/blend_position", direction)

func _on_hurt_box_received_damage(damage: int) -> void:
	health_node.set_temp_invincibility(2)
