extends Node

@onready var timer: Timer = $"../Timer"
@onready var label_score = $LabelScore
@onready var enemy_spawner_1: Marker2D = $"../Enemy/EnemySpawner1"
@onready var enemy_spawner_2: Marker2D = $"../Enemy/EnemySpawner2"
@onready var enemies_left: Label = $"../CanvasLayer/EnemiesLeft"
@onready var next_wave: Label = $"../CanvasLayer/NextWave"
@onready var player: CharacterBody2D = $"../Player"


const BOAR = preload("res://scenes/Enemies/boar_small.tscn")
const BEE = preload("res://scenes/Enemies/small_bee.tscn")

var enemy_instantiate = []
var enemy_count = 10

func _ready():
	enemy_instantiate.resize(enemy_count)
	enemy_instantiate.fill(null)
	timer.autostart = true
	timer.start()

func _process(delta):
	enemies_left.text = "Enemies left: " + str(get_tree().get_nodes_in_group("Enemy").size())
	next_wave.text = "Next wave in: %.f" % timer.time_left

func _on_timer_timeout():
	generate_enemies()
	await get_tree().create_timer(1).timeout

func generate_enemies():
	for i in enemy_count:
		await get_tree().create_timer(2).timeout
		if enemy_instantiate[i] == null:
			var random_enemy = randi() % 2
			if random_enemy == 1:
				enemy_instantiate[i] = BOAR.instantiate()
			else:
				enemy_instantiate[i] = BEE.instantiate()
			enemy_instantiate[i].add_to_group("Enemy")
			enemy_instantiate[i].player = player
			var random_number = randi() % 2
			print(random_number)
			if(random_number == 1):
				enemy_instantiate[i].direction.x = 1
				enemy_instantiate[i].global_position = enemy_spawner_1.global_position
			else:				
				enemy_instantiate[i].direction.x = -1
				enemy_instantiate[i].global_position = enemy_spawner_2.global_position
			add_child(enemy_instantiate[i])
