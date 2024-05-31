extends Control
#This file handles all the buttons for the options menu page


@onready var show_controls = $showControls
@onready var options_menu = $optionsMenu
#@onready var back_from_resolution = $showResolution/VBoxContainer/backFromResolution
#@onready var show_resolution = $showResolution
@onready var back_from_language = $showLanguage/VBoxContainer/backFromLanguage
@onready var show_language = $showLanguage
@onready var button_click = $buttonClick
#@onready var item_list = $showControls/VBoxContainer/ItemList  #declare item_list


func _ready():
	_on_language_changed()  #updates text immediately when the scene is loaded	
	#update_item_list()

func _on_language_changed():
	var language_manager = get_node("/root/LanguageManager")
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

#for updating the Controls as well but didn't work out.
#func update_item_list():
	#var language_manager = get_node("/root/LanguageManager")
	#if language_manager:
		#var items = language_manager.get_list("Keybinds")
		#item_list.clear()
		#for item in items:
			#item_list.add_item(item)

#shows the language area which is invisible to start with
func _on_language_pressed():
	button_click.play()
	show_language.visible = true
	options_menu.visible = false

#func _on_resolution_pressed():
	#button_click.play()
	#show_resolution.visible = true
	#options_menu.visible = false

#Shows the control area which is invisible to start with
func _on_controls_pressed():
	button_click.play()
	show_controls.visible = true
	options_menu.visible = false

#goes back to main menu
func _on_back_pressed():
	button_click.play()
	get_tree().change_scene_to_file("res://views/menu.tscn")

#Hides the control area and displays just the options menu again
func _on_return_pressed():
	button_click.play()
	show_controls.visible = false
	options_menu.visible = true

#Hides the language area and shows the options menu again
func _on_back_from_language_pressed():
	button_click.play()
	show_language.visible = false
	options_menu.visible = true

#Changes language to english
func _on_english_pressed():
	button_click.play()
	show_language.visible = false
	options_menu.visible = true
	LanguageManager.set_language("EN")

#changes language to hungarian
func _on_hungarian_pressed():
	button_click.play()
	show_language.visible = false
	options_menu.visible = true
	LanguageManager.set_language("HU")
