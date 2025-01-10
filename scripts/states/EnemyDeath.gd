extends State

class_name Enemy_Death_State

@export var death_animation_name: String = "death"
@export var animation_tree: AnimationTree
@export var hitbox_collision: CollisionShape2D

func _ready() -> void:
	animation_tree.connect("animation_finished", Callable(self, "_on_animation_finished"))

func Enter():
	hitbox_collision.disabled = true
	playback.travel(death_animation_name)

func _on_animation_finished(anim_name: String):
	if anim_name == death_animation_name:
		character.queue_free()
