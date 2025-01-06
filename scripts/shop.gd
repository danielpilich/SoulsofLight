extends Node2D

@onready var shoptext = $Area2D/ShopLabel
@onready var shoppanel = $Area2D/CanvasLayer/ShopPanel

var entered = false
var shop_window_visible = false
var currency = 100

func _on_area_2d_body_entered(body: Node2D) -> void:
	if body.has_method("player_shop_method"):
		shoptext.visible = true
		entered = true


func _on_area_2d_body_exited(body: Node2D) -> void:
	if body.has_method("player_shop_method"):
		shoptext.visible = false
		entered = false
		shoppanel.visible = false

func _physics_process(delta):
	if entered and Input.is_action_just_pressed("interact"):
		toggle_shop()

func toggle_shop():
	shop_window_visible = !shop_window_visible
	shoppanel.visible = shop_window_visible

func buy_item(item_name: String, cost: int):
	if currency >= cost:
		currency -= cost
		print("Bought item: ",item_name)
		#dodać do inventory
	else:
		print("not enough money")


func _on_item_pressed() -> void:
	buy_item("Item1", 50)


func _on_item_2_pressed() -> void:
	buy_item("Item2", 75)


func _on_item_3_pressed() -> void:
	buy_item("Item3", 25)


func _on_item_4_pressed() -> void:
	buy_item("Item4", 150)
