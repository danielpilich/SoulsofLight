class_name Health
extends Node

signal health_changed(diff: int)
signal health_depleted
signal max_health_changed(diff: int)


@export var max_health: int = 3 : set = set_max_health, get = get_max_health
@export var invinciblility: bool = false : set = set_invincibility, get = get_invincibility

var invincibility_timer: Timer = null

@onready var health: int = max_health


func set_max_health(value: int):
	var clamped_value = 1 if value <= 0 else value
	
	if not clamped_value == max_health:
		var difference = clamped_value - max_health
		max_health = value
		max_health_changed.emit(difference)
		
		if health > max_health:
			health = max_health

func get_max_health() -> int:
	return max_health

func set_invincibility(value: bool):
	invinciblility = value

func get_invincibility() -> int:
	return invinciblility

func set_temp_invincibility(time: float):
	if invincibility_timer == null:
		invincibility_timer = Timer.new()
		invincibility_timer.one_shot = true
		add_child(invincibility_timer)
	
	if invincibility_timer.timeout.is_connected(set_invincibility):
		invincibility_timer.timeout.disconnect(set_invincibility)
	
	invincibility_timer.set_wait_time(time)
	invincibility_timer.timeout.connect(set_invincibility.bind(false))
	invinciblility = true
	invincibility_timer.start()

func set_health(value: int):
	if value < health and invinciblility:
		return
	
	var clamped_value = clampi(value, 0, max_health)
	
	if clamped_value != health:
		var difference = clamped_value - health
		health = value
		health_changed.emit(difference)
		
		if health == 0:
			health_depleted.emit()

func get_health() -> int:
	return health
