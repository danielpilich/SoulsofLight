extends CharacterBody2D

const SPEED = 160.0
const JUMP_VELOCITY = -400.0

@export var is_crouched: bool: set = _set_is_crouched

# Get the gravity from the project settings to be synced with RigidBody nodes.
var gravity = ProjectSettings.get_setting("physics/2d/default_gravity")
var direction : float
var hitbox_original_size: Vector2 = Vector2(28, 26)  # Original standing size
var hurtbox_original_size: Vector2 = Vector2(16, 29)
var collision_original_size: Vector2 = Vector2(14, 29)
var hitbox_crouch_size: Vector2 = Vector2(28, 18)    # Crouched size
var hurtbox_crouch_size: Vector2 = Vector2(16, 23)
var collision_crouch_size: Vector2 = Vector2(14, 23)


@onready var hitbox: Area2D = $HitBox
@onready var health_node: Health = $Health
@onready var animation_player: AnimationPlayer = $AnimationPlayer
@onready var sprite_2d: Sprite2D = $Sprite2D
@onready var animation_tree: AnimationTree = $AnimationTree
@onready var state_machine: StateMachine = $StateMachine
@onready var collision: CollisionShape2D = $CollisionShape2D
@onready var hurtbox: CollisionShape2D = $HurtBox/CollisionShape2D
@onready var hit_box: CollisionShape2D = $HitBox/CollisionShape2D


func _ready():
	animation_tree.active = true
	#print("collshape size: ", collision.shape.size)
	#print("hitbox size: ", hit_box.shape.size)
	#print("hurtbox size: ", hurtbox.shape.size)

func _physics_process(delta):
	# Add the gravity.
	if not is_on_floor():
		velocity.y += gravity * delta

	# Get the input direction: -1, 0, 1
	direction = Input.get_axis("move_left", "move_right")
	
	#Flip the Sprite
	if direction > 0:
		sprite_2d.scale.x = 0.75
		if hitbox.scale.x < 0:
			#weapon_sprite.scale.x *= -1
			hitbox.scale.x *= -1
	elif direction < 0:
		sprite_2d.scale.x = -0.75
		if hitbox.scale.x > 0:
			#weapon_sprite.scale.x *= -1
			hitbox.scale.x *= -1

	#Apply movement
	if direction and state_machine.current_state.can_move:
		velocity.x = direction * SPEED
	else:
		velocity.x = move_toward(velocity.x, 0, SPEED)

	move_and_slide()
	update_animation()

func _set_is_crouched(value: bool):
	if is_crouched == value:
		return
	
	is_crouched = value
	update_collision_shape()

func update_collision_shape():
	var hitshape = hit_box.shape
	var hurtshape = hurtbox.shape
	var collshape = collision.shape
	hitshape.size = hitbox_crouch_size if is_crouched else hitbox_original_size
	hit_box.position.y = -11 if is_crouched else -15 #zmiana offsetu dla collisionshape
	hurtshape.size = hurtbox_crouch_size if is_crouched else hurtbox_original_size
	hurtbox.position.y = -11.5 if is_crouched else -14.5
	collshape.size = collision_crouch_size if is_crouched else collision_original_size
	collision.position.y = -11.5 if is_crouched else -14.5

func update_animation():
	animation_tree.set("parameters/move/blend_position", direction)
	animation_tree.set("parameters/crouch/blend_position", direction)

func _on_hurt_box_received_damage(damage: int) -> void:
	health_node.set_temp_invincibility(2)


func _on_health_health_depleted() -> void:
	pass # Replace with function body.
