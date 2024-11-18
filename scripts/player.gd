extends CharacterBody2D

const SPEED = 130.0
const JUMP_VELOCITY = -300.0

# Get the gravity from the project settings to be synced with RigidBody nodes.
var gravity = ProjectSettings.get_setting("physics/2d/default_gravity")

@onready var animated_sprite = $AnimatedSprite2D
@onready var weapon_sprite: AnimatedSprite2D = $Weapon/AnimatedSprite2D
@onready var weapon_animation_player: AnimationPlayer = $Weapon/AnimationPlayer
@onready var weapon: Node2D = $Weapon


func _physics_process(delta):
	# Add the gravity.
	if not is_on_floor():
		velocity.y += gravity * delta

	# Handle jump.
	if Input.is_action_just_pressed("jump") and is_on_floor():
		velocity.y = JUMP_VELOCITY

	# Equid/Unequip weapon
	if Input.is_action_just_pressed("equip_weapon"):
		weapon.visible = not weapon.visible

	# Handle attack.
	if weapon.visible == true and Input.is_action_just_pressed("attack"):
		weapon.get_node("CollisionShape2D").disabled = false
		weapon_sprite.play("swing")		
		if weapon.scale.x < 0:
			weapon_animation_player.play("swing_left")
		elif weapon.scale.x > 0:
			weapon_animation_player.play("swing_right")
		await weapon_animation_player.animation_finished
		weapon.get_node("CollisionShape2D").disabled = true

	# Get the input direction: -1, 0, 1
	var direction = Input.get_axis("move_left", "move_right")
	
	#Flip the Sprite
	if direction > 0:
		animated_sprite.flip_h = false
		weapon_sprite.flip_h = false
		if weapon.scale.x < 0:
			weapon_sprite.scale.x *= -1
			weapon.scale.x *= -1
	elif direction < 0:
		animated_sprite.flip_h = true
		weapon_sprite.flip_h = true
		if weapon.scale.x > 0:
			weapon_sprite.scale.x *= -1
			weapon.scale.x *= -1
		
	# Play animations
	if is_on_floor():
		if direction == 0:
			animated_sprite.play("idle")
		else:
			animated_sprite.play("run")
	else:
		animated_sprite.play("jump")

	#Apply movement	
	if direction:
		velocity.x = direction * SPEED
	else:
		velocity.x = move_toward(velocity.x, 0, SPEED)

	move_and_slide()

func player_shop_method():
	pass
