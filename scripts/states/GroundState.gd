extends State

class_name GroundState

@onready var left_step: AudioStreamPlayer2D = $"../../LeftStep"
@onready var animation_player: AnimationPlayer = $"../../AnimationPlayer"
@onready var animation_tree: AnimationTree = $"../../AnimationTree"

@export var jump_velocity = -300.0

func Update(_delta: float):
	if character and Input.is_action_just_pressed("jump"):
			jump()
	
	if !character.is_on_floor() and !character.is_on_wall():
		playback.travel("fall")
		emit_signal("Transitioned", self, "Air")
	
	if Input.is_action_just_pressed("down"):
		emit_signal("Transitioned", self, "crouch")
	
	if Input.is_action_just_pressed("attack"):
		attack()


func jump():
	character.velocity.y = jump_velocity
	playback.travel("jump")
	emit_signal("Transitioned", self, "air")

func attack():
	playback.travel("attack1")
	emit_signal("Transitioned", self, "attack")

func Enter():
	if character:
		character.is_crouched = false
	if playback:
		playback.travel("move")

func Exit():
	pass

func _on_health_health_depleted() -> void:
	is_dead = true
	emit_signal("Transitioned", self, "death")

func _on_hurt_box_received_damage(damage: int) -> void:
	if !is_dead:
		emit_signal("Transitioned", self, "hit")
