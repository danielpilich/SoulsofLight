extends State
class_name PlayerRun

@onready var player: CharacterBody2D = $"../.."
@onready var animation_player: AnimationPlayer = $"../../AnimationPlayer"


func Enter() -> void:
	if animation_player:
		animation_player.play("run")

func Update(_delta: float):
	if player.is_on_floor() and player.direction == 0:
		emit_signal("Transitioned", self, "idle")
	
	if Input.is_action_just_pressed("jump"):
		emit_signal("Transitioned", self, "jump")
	
	if player.velocity.y > 0:
		emit_signal("Transitioned", self, "fall")
	
	if Input.is_action_just_pressed("attack"):
		emit_signal("Transitioned", self, "attack")

func _on_health_health_depleted() -> void:
	emit_signal("Transitioned", self, "death")

func _on_hurt_box_received_damage(damage: int) -> void:
	emit_signal("Transitioned", self, "hit")
