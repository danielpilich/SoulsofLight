extends HBoxContainer

@export var heart_full: Texture
@export var heart_empty: Texture
@export var character: CharacterBody2D

@onready var health: Health = character.get_node("Health")
@onready var value : int = health.health

func _ready() -> void:
	health.health_changed.connect(_update_health)
	health.max_health_changed.connect(_update_max_health)
	setup()


func setup():
	for child in get_children():
		child.queue_free()
	
	await get_tree().process_frame
	
	for i in range(health.max_health):
		var heart = TextureRect.new()
		heart.texture = heart_full
		heart.stretch_mode = TextureRect.STRETCH_SCALE
		heart.name = str(i)
		add_child(heart)
	
	_update_health(0)

func _update_health(diff: int):
	for i in range(get_child_count()):
		if i < health.health :
			get_child(i).texture = heart_full
		else:
			get_child(i).texture = heart_empty

func _update_max_health(diff: int):
	setup()
