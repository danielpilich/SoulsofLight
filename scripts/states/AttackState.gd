extends State
class_name AttackState

@onready var hitbox: CollisionShape2D = $"../../HitBox/CollisionShape2D"
@onready var timer: Timer = $Timer
@onready var sword_swing: AudioStreamPlayer2D = $"../../SwordSwing"

var anim: String = "attack1"
var switch: bool = false

func Enter() -> void:	
	sword_swing.play()
	hitbox.disabled = false
	timer.start()

func Exit() -> void:
	hitbox.disabled = true
	timer.stop()

#func _ready() -> void:
	#timer.connect("timeout", Callable(self, "on_timer_timeout"))

func Update(_delta: float):
	#if Input.is_action_just_pressed("attack"):
		#timer.start()
	anim = playback.get_current_node()



func _on_animation_tree_animation_finished(anim_name: StringName) -> void:
	if anim_name == "attack1":
		hitbox.disabled = true
		emit_signal("Transitioned", self, "ground")
	elif anim_name == "attack2":
		hitbox.disabled = true
		emit_signal("Transitioned", self, "air")
	elif anim_name == "crouch_attack":
		hitbox.disabled = true
		emit_signal("Transitioned", self, "crouch")
	else:
		hitbox.disabled = true

func _on_health_health_depleted() -> void:
	emit_signal("Transitioned", self, "death")

func _on_hurt_box_received_damage(damage: int) -> void:
	emit_signal("Transitioned", self, "hit")

func _on_timer_timeout():
	if anim == "attack1":
		hitbox.disabled = true
		emit_signal("Transitioned", self, "ground")
	elif anim == "attack2":
		hitbox.disabled = true
		emit_signal("Transitioned", self, "air")
	elif anim == "crouch_attack":
		hitbox.disabled = true
		emit_signal("Transitioned", self, "crouch")
