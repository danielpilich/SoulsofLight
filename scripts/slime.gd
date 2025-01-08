extends CharacterBody2D

const SPEED = 30
const JUMP_VELOCITY = -350.0

var direction = 1
var gravity = ProjectSettings.get_setting("physics/2d/default_gravity")

@onready var ray_cast_right: RayCast2D = $RayCastRight
@onready var ray_cast_left: RayCast2D = $RayCastLeft
@onready var animated_sprite = $AnimatedSprite2D
@onready var health: Health = $Health

func _physics_process(delta):
	# Add the gravity.
	if not is_on_floor():
		velocity.y += gravity * delta

	# Handle jump.
	if (ray_cast_right.is_colliding() or ray_cast_left.is_colliding()) and is_on_floor():
		velocity.y = JUMP_VELOCITY
		
	if is_on_floor():
		animated_sprite.play("default")
	else:
		animated_sprite.play("jump")
	
	if direction == 1:
		animated_sprite.flip_h = false
	else:
		animated_sprite.flip_h = true

	velocity.x = direction * SPEED

	move_and_slide()

func _on_hurt_box_received_damage(damage: int) -> void:
	animated_sprite.play("slime_hit")
	health.set_temp_invincibility(0.5)
	await animated_sprite.animation_finished
	animated_sprite.play("default")

func _on_health_health_depleted() -> void:
	queue_free()
