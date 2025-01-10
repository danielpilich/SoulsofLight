extends Control


func _on_play_button_pressed() -> void:	
	get_tree().change_scene_to_file("res://scenes/game.tscn")


func _on_keybinds_button_pressed() -> void:
	get_tree().change_scene_to_file("res://scenes/keybinds_menu.tscn")


func _on_quit_button_pressed() -> void:
	get_tree().quit()
