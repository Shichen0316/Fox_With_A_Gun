extends Control


@onready var resume_game = $MarginContainer/VBoxContainer/Resume_Game as Button

func _ready():
	_on_language_changed()  # Update text immediately when the scene is loaded

func _on_language_changed():
	var language_manager = get_node("/root/LanguageManager")  # Adjust the path as necessary
	if language_manager:
		for node in get_tree().get_nodes_in_group("translatable"):
			var key = node.name
			if node.has_method("set_text"):
				node.set_text(language_manager.get_text(key))
			elif node.has_method("set_caption"):
				node.set_caption(language_manager.get_text(key))
			else:
				node.text = language_manager.get_text(key)
	else:
		print("LanguageManager node not found")

func _on_resume_game_pressed():
	get_tree().change_scene_to_file("res://Level/game_level.tscn")


func _on_main_menu_pressed():
	get_tree().change_scene_to_file("res://views/menu.tscn")
