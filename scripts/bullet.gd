extends RigidBody2D

@export var speed: float = 500

var direction: Vector2 = Vector2.ZERO
var velocity: Vector2 = Vector2.ZERO

@onready var sprite_2d: Sprite2D = $Sprite2D
@onready var hit_box: HitBox = $HitBox

func _ready() -> void:
	velocity = direction * speed

func set_direction(new_direction: Vector2):
	direction = new_direction

func _process(delta: float) -> void:
	position += direction * speed * delta
