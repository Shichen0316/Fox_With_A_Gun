#all of the text elements that you want to update when switching 
#languages should be named after their corresponding keys in the dictionary 
#and must be added to the "translatable" group in the Inspector < Node tab

extends Node

func _ready():
	# directly use the LanguageManager autoload singleton to set the button's text
	$Language_switcher.text = LanguageManager.get_text("changeLanguage")

func _on_button_pressed():
	if LanguageManager.current_language == "EN":
		LanguageManager.set_language("HU")
	else:
		LanguageManager.set_language("EN")
	$Language_switcher.text = LanguageManager.get_text("changeLanguage")
