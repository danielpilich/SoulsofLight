extends State

class_name Enemy_Walk_State

@export var walk_animation_name: String = "walk"
@export var hurt_box: HurtBox

func Enter():
	hurt_box.connect("received_damage", Callable(self, "_on_received_damage"))

func Physics_Update(delta: float):
	pass

func _on_received_damage(damage: int) -> void:
	emit_signal("Transitioned", self, "hit")
