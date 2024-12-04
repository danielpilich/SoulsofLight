extends State
class_name PlayerAttack

@onready var player: CharacterBody2D = $"../.."
@onready var animation_player: AnimationPlayer = $"../../AnimationPlayer"
@onready var collision_shape_2d: CollisionShape2D = $"../../HitBox/CollisionShape2D"

var anim_fini: bool = false

func Enter() -> void:
	anim_fini = false
	collision_shape_2d.disabled = false
	if animation_player:
		animation_player.play("attack2")
		await animation_player.animation_finished
		anim_fini = true
		collision_shape_2d.disabled = true

func Update(_delta: float):
	if anim_fini == true:
		if player.is_on_floor() and player.direction == 0:
			emit_signal("Transitioned", self, "idle")
		
		if player.is_on_floor() and player.direction != 0:
			emit_signal("Transitioned", self, "run")
		
		if player.velocity.y > 0:
			emit_signal("Transitioned", self, "fall")
		elif player.velocity.y < 0:
			emit_signal("Transitioned", self, "jump")


func _on_hurt_box_received_damage(damage: int) -> void:
	emit_signal("Transitioned", self, "hit")
