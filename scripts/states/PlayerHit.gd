extends State
class_name PlayerHit

@onready var animation_player: AnimationPlayer = $"../../AnimationPlayer"

#func Enter() -> void:
	#if animation_player:
		#animation_player.play("hit")
		#animation_player.animation_finished.connect(_on_animation_finished)
#
#func Exit() -> void:
	#determine_next_state()
	#
	#if animation_player:
		#animation_player.animation_finished.disconnect(_on_animation_finished)
		#print("loop done")
#
#func Update(_delta: float):
	#pass
#
#func _on_animation_finished(anim_name: String):
	#if anim_name == "hit":
		#emit_signal("Transitioned", self, next_state_name)
#

#func _on_animation_tree_animation_finished(anim_name: StringName) -> void:
	#if anim_name == "hit":
		#if player.is_on_floor():
			#emit_signal("Transitioned", self, "move")
		#else:
			#emit_signal("Transitioned", self, "air")
	#if anim_name == "hit_wall":
		#emit_signal("Transitioned", self, "wall")
	#if anim_name == "hit_crouched":
		#emit_signal("Transitioned", self, "crouch")
