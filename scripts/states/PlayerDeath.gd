extends State
class_name PlayerDeathState

@onready var animation_player: AnimationPlayer = $"../../AnimationPlayer"

func Enter() -> void:	
	playback.travel("death")

func _on_animation_tree_animation_finished(anim_name: StringName) -> void:
	if anim_name == "death":
		get_tree().reload_current_scene()
		queue_free()
