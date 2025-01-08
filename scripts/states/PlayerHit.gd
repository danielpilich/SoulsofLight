extends State
class_name PlayerHitState

@onready var animation_player: AnimationPlayer = $"../../AnimationPlayer"

func Enter() -> void:
	playback.travel("hit")

func _on_animation_tree_animation_finished(anim_name: StringName) -> void:
	if anim_name == "hit":
		if player.is_on_floor():
			emit_signal("Transitioned", self, "ground")
		else:
			emit_signal("Transitioned", self, "air")
	if anim_name == "hit_crouched":
		emit_signal("Transitioned", self, "crouch")
