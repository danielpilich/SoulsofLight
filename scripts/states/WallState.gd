extends State
class_name WallState



func _on_health_health_depleted() -> void:
	emit_signal("Transitioned", self, "death")
