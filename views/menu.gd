extends Control
@onready var button_click = $buttonClick


func _on_play_pressed():
	button_click.play()
	get_tree().change_scene_to_file("res://Level/game_level.tscn")


func _on_tutorial_pressed():
	button_click.play()
	pass


func _on_options_pressed():
	button_click.play()
	get_tree().change_scene_to_file("res://views/options_menu.tscn")


func _on_quit_pressed():
	button_click.play()
	get_tree().quit()
