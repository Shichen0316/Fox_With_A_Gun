extends Node

func _ready():
	# directly use the LanguageManager autoload singleton to set the button's text
	$Button_test.text = LanguageManager.get_text("thisisatest")

func _on_button_pressed():
	if LanguageManager.current_language == "EN":
		LanguageManager.set_language("HU")
	else:
		LanguageManager.set_language("EN")
	$Button_test.text = LanguageManager.get_text("thisisatest")
