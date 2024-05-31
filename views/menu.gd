extends Control
@onready var button_click = $buttonClick



#Start menu page which plays when launching the game. This handles all the buttons on the screen
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

#@onready var button_click = $buttonClick
#@onready var language_manager_path = "res://languages/LanguageManager.tscn" 
#@onready var language_manager = get_node(language_manager_path)  # Store the reference to the LanguageManager node
#
#func _ready():
	#if language_manager:
		#_on_language_changed()
#
#func _on_language_changed():
	#for node in get_tree().get_nodes_in_group("translatable"):
		#var key = node.name
		#if node.has_method("set_text"):
			#node.set_text(language_manager.get_text(key))
		#elif node.has_method("set_caption"):
			#node.set_caption(language_manager.get_text(key))
		#else:
			#node.text = language_manager.get_text(key)

#When pressing play, it changes the scene to the game scene
func _on_play_pressed():
	button_click.play()
	get_tree().change_scene_to_file("res://Level/game_level.tscn")

#Changes the scene to the tutorial
func _on_tutorial_pressed():
	button_click.play()
	get_tree().change_scene_to_file("res://Level/tutorial_level.tscn")

#Changes the scene to the options_menu
func _on_options_pressed():
	button_click.play()
	get_tree().change_scene_to_file("res://views/options_menu.tscn")

#Exits the game
func _on_quit_pressed():
	button_click.play()
	get_tree().quit()
