extends State

class_name Enemy_Hit_State

@export var health: Health
@export var state_machine: StateMachine
@export var hit_animation_name: String = "hit"
@export var animation_tree: AnimationTree

func _ready() -> void:
	animation_tree.connect("animation_finished", Callable(self, "_on_animation_finished"))

func Enter():
	playback.travel(hit_animation_name)

func _on_animation_finished(anim_name: String):
	if anim_name == hit_animation_name:
		if health.get_health() <= 0:
			emit_signal("Transitioned", self, "death")
		else:
			emit_signal("Transitioned", self, "walk")
