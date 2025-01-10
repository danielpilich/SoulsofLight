extends State
class_name CrouchState

func Enter():
	character.is_crouched = true
	playback.travel("crouch")

func Update(_delta: float):
	if !Input.is_key_pressed(KEY_DOWN):
		emit_signal("Transitioned", self, "ground")
	
	if Input.is_action_just_pressed("attack"):
		attack()

func attack():
	playback.travel("crouch_attack")
	emit_signal("Transitioned", self, "attack")

func _on_health_health_depleted() -> void:
	emit_signal("Transitioned", self, "death")
