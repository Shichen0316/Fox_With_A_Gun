extends Control


@onready var resume_game = $MarginContainer/VBoxContainer/Resume_Game as Button



func _on_resume_game_pressed():
	get_tree().change_scene_to_file("res://Level/game_level.tscn")


func _on_main_menu_pressed():
	get_tree().change_scene_to_file("res://views/menu.tscn")
