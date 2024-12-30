extends State

class_name GroundState

@export var jump_velocity = -300.0

func Update(_delta: float):
	if player and Input.is_action_just_pressed("jump"):
			jump()

func jump():
	player.velocity.y = jump_velocity
	emit_signal("Transitioned", self, "air")
