extends Control
@onready var show_controls = $showControls
@onready var options_menu = $optionsMenu
@onready var back_from_resolution = $showResolution/VBoxContainer/backFromResolution
@onready var show_resolution = $showResolution
@onready var back_from_language = $showLanguage/VBoxContainer/backFromLanguage
@onready var show_language = $showLanguage
@onready var button_click = $buttonClick




func _on_language_pressed():
	button_click.play()
	show_language.visible = true
	options_menu.visible = false

func _on_resolution_pressed():
	button_click.play()
	show_resolution.visible = true
	options_menu.visible = false

func _on_controls_pressed():
	button_click.play()
	show_controls.visible = true
	options_menu.visible = false



func _on_back_pressed():
	button_click.play()
	get_tree().change_scene_to_file("res://views/menu.tscn")


func _on_return_pressed():
	button_click.play()
	show_controls.visible = false
	options_menu.visible = true

func _on_back_from_resolution_pressed():
	button_click.play()
	show_resolution.visible = false
	options_menu.visible = true
	


func _on_back_from_language_pressed():
	button_click.play()
	show_language.visible = false
	options_menu.visible = true




func _on_english_pressed():
	
	#add script to replace UI and language
	button_click.play()
	show_language.visible = false
	options_menu.visible = true



func _on_hungarian_pressed():
	
	
	#add script to replace UI and language
	button_click.play()
	show_language.visible = false
	options_menu.visible = true
	


func _on_swedish_pressed():
	
	
	#add script to replace UI and language
	button_click.play()
	show_language.visible = false
	options_menu.visible = true
	
