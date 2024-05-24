# LanguageManager node acts as the central manager for language changes
extends Node

var languages = {
	"EN": {
		"changeLanguage":"Change language",
		"youAreDead":"You are dead",
		"gameTitle":"Game Title",
		"Hungarian":"Hungarian",
		"English":"English",
		"backFromLanguage":"Back",
		"Language":"Language",
		"Resolution":"Resolution",
		#"Controls":"Controls"
	},
		"HU": {
		"changeLanguage":"Másik nyelv",
		"youAreDead":"A játéknak vége",
		"gameTitle":"Játék címe",
		"Hungarian":"Magyar",
		"English":"Angol",
		"backFromLanguage":"Vissza",
		"Language":"Nyelv",
		"Resolution":"Felbontás",
		#"Controls":"Irányítás"
	},
}

var current_language = "EN"

# retrieve the translation for the given key in the current language
func get_text(key: String) -> String:
	return languages[current_language].get(key, "Translation not found")

# change the current language and update all translatable nodes
func set_language(language_code: String) -> void:
	if languages.has(language_code):
		current_language = language_code
		update_translatable_nodes()
	else:
		print("Language not supported: %s" % language_code)

# update all translatable nodes with the correct language text
func update_translatable_nodes() -> void:
	for node in get_tree().get_nodes_in_group("translatable"):
		var key = node.name  # Use node's name as the key
		if node.has_method("set_text"):  # Check if node has set_text method
			node.set_text(get_text(key))
		elif node.has_method("set_caption"):  # For Controls that use captions
			node.set_caption(get_text(key))
		else: 
			node.text = get_text(key)
