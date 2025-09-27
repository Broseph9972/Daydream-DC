extends MarginContainer

func _on_play_button_pressed() -> void:
	get_tree().change_scene_to_file("res://scenes/Level.tscn")

func _on_levels_button_pressed() -> void:
	get_tree().change_scene_to_file("res://scenes/Level.tscn")

func _on_options_button_pressed() -> void:
	pass # TODO: Make options screen

func _on_quit_button_pressed() -> void:
	get_tree().quit()
