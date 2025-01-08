extends State
class_name AttackState

@onready var hitbox: CollisionShape2D = $"../../HitBox/CollisionShape2D"
@onready var timer: Timer = $Timer

var switch: bool = false

func Enter() -> void:
	hitbox.disabled = false

func Exit() -> void:
	hitbox.disabled = true

func Update(_delta: float):
	if Input.is_action_just_pressed("attack"):
		timer.start()

func _on_animation_tree_animation_finished(anim_name: StringName) -> void:
	if anim_name == "attack1":
		hitbox.disabled = true
		#if timer.is_stopped():
		playback.travel("move")
		emit_signal("Transitioned", self, "ground")
		#else:
			#hitbox.disabled = false
			#playback.travel("attack2") 
	#if anim_name == "attack2":
		#hitbox.disabled = true
		#emit_signal("Transitioned", self, "ground")
	if anim_name == "crouch_attack":
		hitbox.disabled = true
		emit_signal("Transitioned", self, "crouch")
	else:
		hitbox.disabled = true

func _on_health_health_depleted() -> void:
	emit_signal("Transitioned", self, "death")

func _on_hurt_box_received_damage(damage: int) -> void:
	timer.stop()
	emit_signal("Transitioned", self, "hit")
