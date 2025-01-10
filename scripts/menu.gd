extends Control

@onready var main_menu: VBoxContainer = $MarginContainer/MainMenu
@onready var keybinds_menu: VBoxContainer = $MarginContainer/KeybindsMenu

func _ready() -> void:	
	keybinds_menu.visible = false

func _on_play_button_pressed() -> void:	
	get_tree().change_scene_to_file("res://scenes/game.tscn")


func _on_keybinds_button_pressed() -> void:
	main_menu.visible = false
	keybinds_menu.visible = true


func _on_quit_button_pressed() -> void:
	get_tree().quit()


func _on_return_button_pressed() -> void:
	main_menu.visible = true
	keybinds_menu.visible = false
