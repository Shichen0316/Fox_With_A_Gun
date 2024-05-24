# LanguageManager node acts as the central manager for language changes
extends Node

signal language_changed

# dictionary for elements in English and Hungarian
var languages = {
	"EN": {
		"changeLanguage":"Change language",
		"youAreDead":"You are dead",
		"Hungarian":"Hungarian",
		"English":"English",
		"backFromLanguage":"Back",
		"Language":"Language",
		"Resolution":"Resolution",
		"Controls":"Controls",
		"Volume":"Volume",
		"Back":"Back",
		"gameTitle":"Cherry Ice Cream",
		"Play":"Play",
		"Tutorial":"Tutorial",
		"Options":"Options",
		"Quit":"Quit",
		"Keybinds": ["Up", "Left", "Right", "Down", "Pick up weapon", "Drop weapon", "Shoot"],
		"Resume_Game":"Resume_Game",
		"Main_Menu":"Main_Menu",
		"resumeGame":"Resume",
		"restartGame":"Restart",
		"goMainMenu":"Back to Main",
		"gameOver":"Game Over",
		"playAgain":"Play Again",
	},
		"HU": {
		"changeLanguage":"Másik nyelv",
		"youAreDead":"A játéknak vége",
		"Hungarian":"Magyar",
		"English":"Angol",
		"backFromLanguage":"Vissza",
		"Language":"Nyelv",
		"Resolution":"Felbontás",
		"Controls":"Irányítás",
		"Volume":"Hangerő",
		"Back":"Vissza",
		"gameTitle":"Cseresznyés Fagyi",
		"Play":"Kezdés",
		"Tutorial":"Útmutató",
		"Options":"Beállítások",
		"Quit":"Kilépés",
		"Keybinds": ["Fel", "Bal", "Jobb", "Le", "Fegyver felvesz", "Fegyver elejt", "Lövés"],
		"Resume_Game":"Játek_szünet",
		"Main_Menu":"Fő_Menü",
		"resumeGame":"Szünet",
		"restartGame":"Újrakezdés",
		"goMainMenu":"Fő menű",
		"gameOver":"Halott vagy",
		"playAgain":"Játssz újra",
	},
}

# defualt language is English
var current_language = "EN"

# retrieve the translation for the given key in the current language
func get_text(key: String) -> String:
	return languages[current_language].get(key, "Translation not found")	

#func get_list(key: String) -> Array:
	#return languages[current_language].get(key, [])

# change the current language and update all translatable nodes
func set_language(language_code: String) -> void:
	if languages.has(language_code):
		current_language = language_code
		#emit_signal("language_changed")
		update_translatable_nodes()
	else:
		print("Language not supported: %s" % language_code)

# update all translatable nodes with the correct language text
func update_translatable_nodes() -> void:
	for node in get_tree().get_nodes_in_group("translatable"):
		var key = node.name  # using the node's name as the key
		if node.has_method("set_text"): 
			node.set_text(get_text(key))
		elif node.has_method("set_caption"):  # for Controls that use captions
			node.set_caption(get_text(key))
		else: 
			node.text = get_text(key)
