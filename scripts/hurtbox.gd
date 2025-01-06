class_name HurtBox
extends Area2D

signal received_damage(damage: int)

@export var health: Health

var current_hitbox: HitBox = null

func _ready():
	connect("area_entered", _on_area_entered)
	connect("area_exited", _on_area_exited)

func _on_area_entered(hitbox: HitBox) -> void:
	if hitbox != null:
		current_hitbox = hitbox
		apply_damage()

func _on_area_exited(hitbox: HitBox):
	if hitbox == current_hitbox:
		current_hitbox = null

func apply_damage():
	if current_hitbox.collision_shape.disabled == true:
		return
	
	if current_hitbox != null and !health.invincibility:
		print("damage")
		health.health -= current_hitbox.damage
		received_damage.emit(current_hitbox.damage)
	
	if health.invincibility_timer:
		health.invincibility_timer.timeout.connect(_on_invincibility_ended)

func _on_invincibility_ended():
	if current_hitbox != null:
		print("damage 2")
		apply_damage()
