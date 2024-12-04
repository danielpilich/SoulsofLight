extends State
class_name PlayerDeath

@onready var player: CharacterBody2D = $"../.."
@onready var animation_player: AnimationPlayer = $"../../AnimationPlayer"

var anim_fini: bool = false

func Enter() -> void:	
	anim_fini = false
	if animation_player:
		animation_player.play("death")
		await animation_player.animation_finished
		anim_fini = true

func Update(_delta: float):
	if anim_fini == true:
		get_tree().reload_current_scene()
		queue_free()
