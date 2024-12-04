extends State
class_name PlayerFall

@onready var player: CharacterBody2D = $"../.."
@onready var animation_player: AnimationPlayer = $"../../AnimationPlayer"


func Enter() -> void:
	if animation_player:
		animation_player.play("fall")

func Update(_delta: float):
	if player.is_on_floor() and player.direction == 0:
		emit_signal("Transitioned", self, "idle")
	
	if player.is_on_floor() and player.direction != 0:
		emit_signal("Transitioned", self, "run")
	
	if Input.is_action_just_pressed("attack"):
		emit_signal("Transitioned", self, "attack")


func _on_hurt_box_received_damage(damage: int) -> void:
	emit_signal("Transitioned", self, "hit")
