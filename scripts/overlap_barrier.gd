extends Area2D

@export var avoid_distance: float = 10

func _ready() -> void:
	connect("body_entered", Callable(self, "on_area2d_body_entered"))

func _on_area2D_body_entered(body: CharacterBody2D):
	if body.has_method("overlap_protection"):
		var direction = global_position - body.global_position
		var distance = direction.length()
		
		if distance < avoid_distance:
			direction = direction.normalized() * (avoid_distance - distance)
			body.global_position += direction
