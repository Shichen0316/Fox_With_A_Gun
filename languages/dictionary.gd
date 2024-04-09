extends Node

var languages = {
	"EN": {
		"hello": "Hello",
		"goodbye": "Goodbye",
		"thisisatest": "This is a test"
		# ... more translations
	},
		"HU": {
		"hello": "Szia",
		"thisisatest": "Tesztelve lesz"
		# translations after English is completed
	},
		"SE": {
		# translations after English is completed
	}
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
		node.text = get_text(key)
