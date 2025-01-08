class_name HitBox
extends Area2D

@onready var collision_shape: CollisionShape2D = $CollisionShape2D

@export var damage: int = 1 : set = set_damage, get = get_damage

func set_damage(value: int):
	damage = value

func get_damage() -> int:
	return damage
