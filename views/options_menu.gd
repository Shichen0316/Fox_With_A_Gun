extends Control
@onready var show_controls = $showControls
@onready var options_menu = $optionsMenu




func _on_language_pressed():
	pass # Replace with function body.


func _on_resolution_pressed():
	pass # Replace with function body.


func _on_controls_pressed():
	show_controls.visible = true
	options_menu.visible = false
	
func _on_volume_pressed():
	pass # Replace with function body.


func _on_back_pressed():
	get_tree().change_scene_to_file("res://views/menu.tscn")


func _on_return_pressed():
	show_controls.visible = false
	options_menu.visible = true
