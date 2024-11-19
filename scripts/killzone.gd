extends Area2D

@onready var timer = $Timer


func _on_body_entered(body):
	if body.get_name() == "Player":
		print(body.health)
		body.get_hit()
		if body.health == 0:
			Engine.time_scale = 0.4
			timer.start()
	
func _on_timer_timeout():
	Engine.time_scale = 1.0
	get_tree().reload_current_scene()
	queue_free()
