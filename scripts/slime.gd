extends CharacterBody2D

const SPEED = 30

var direction = 1
@onready var ray_cast_right = $RayCastRight
@onready var ray_cast_left = $RayCastLeft
@onready var animated_sprite = $AnimatedSprite2D
@onready var health: Health = $Health

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	if ray_cast_right.is_colliding():
		direction = -1
		animated_sprite.flip_h = true
	if ray_cast_left.is_colliding():
		direction = 1
		animated_sprite.flip_h = false
	position.x += direction * SPEED * delta

func _on_hurt_box_received_damage(damage: int) -> void:
	animated_sprite.play("slime_hit")
	health.set_temp_invincibility(0.5)
	await animated_sprite.animation_finished
	animated_sprite.play("default")

func _on_health_health_depleted() -> void:
	queue_free()
