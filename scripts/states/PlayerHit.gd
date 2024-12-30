extends State
class_name PlayerHit

@onready var animation_player: AnimationPlayer = $"../../AnimationPlayer"

var next_state_name: String = "idle"

func Enter() -> void:
	if animation_player:
		animation_player.play("hit")
		animation_player.animation_finished.connect(_on_animation_finished)

func Exit() -> void:
	determine_next_state()
	
	if animation_player:
		animation_player.animation_finished.disconnect(_on_animation_finished)
		print("loop done")

func Update(_delta: float):
	pass

func _on_animation_finished(anim_name: String):
	if anim_name == "hit":
		emit_signal("Transitioned", self, next_state_name)

func determine_next_state():
	if player.is_on_floor():
		if player.direction != 0:
			next_state_name = "run"
		else:
			next_state_name = "idle"
	else:
		next_state_name = "fall"
