extends Control





func _on_play_pressed():
	get_tree().change_scene_to_file("res://Level/game_level.tscn")


func _on_tutorial_pressed():
	pass


func _on_options_pressed():
	get_tree().change_scene_to_file("res://views/options_menu.tscn")


func _on_quit_pressed():
	get_tree().quit()
