extends State
class_name BeeAttack

func Enter():
	character.create_bullet()
	playback.travel("attack_back")

func _on_animation_tree_animation_finished(anim_name: StringName) -> void:
	if anim_name == "BeeAttack":
		emit_signal("Transitioned", self, "walk")
