extends State

class_name AirState

@export var double_jump_velocity: float = -300
@export var double_jump_unlocked: bool = false

var has_double_jumped: bool = false
var is_attacking: bool = false

func Update(_delta: float):
	if character.is_on_floor():
		emit_signal("Transitioned", self, "Ground")
	
	if Input.is_action_just_pressed("attack"):
		is_attacking = true
		playback.travel("attack2")
		emit_signal("Transitioned", self, "attack")
	
	if !character.is_on_floor() and !is_attacking:
		if character.velocity.y > 0:
			playback.travel("fall")
		elif character.velocity.y < 0:
			playback.travel("jump")
	
	if Input.is_action_just_pressed("jump") and !has_double_jumped and double_jump_unlocked:
		double_jump()

func Enter():
	character.is_crouched = false
	is_attacking = false

func Exit():
	has_double_jumped = false

func double_jump():
	character.velocity.y = double_jump_velocity
	playback.travel("jump")
	has_double_jumped = true

func _on_health_health_depleted() -> void:
	is_dead = true
	emit_signal("Transitioned", self, "death")

func _on_hurt_box_received_damage(damage: int) -> void:
	if !is_dead:
		emit_signal("Transitioned", self, "hit")
