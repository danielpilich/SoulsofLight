extends Area2D

@onready var timer = $Timer


func _on_body_entered(body):
	print("you died")
	Engine.time_scale = 0.6
	timer.start()
	
func _on_timer_timeout():
	Engine.time_scale = 1.0
	queue_free()
