# This file handles the initialization and gameplay mechanics, including spawning enemies, managing weapons, handling player interactions, and implementing language changes.
extends Node2D
@onready var button_click = $buttonClick
@onready var game_label = $CanvasLayer2/gameLabel
@onready var game_timer = $CanvasLayer2/gameLabel/gameTimer


var weapon_scenes = {
	"rifle": preload("res://weapons/rifle.tscn"),
	"laser_gun": preload("res://weapons/laser_gun.tscn"),
	"light_saber": preload("res://weapons/light_saber.tscn"),
	"shotgun": preload("res://weapons/shotgun.tscn"),
	"rocket_launcher": preload("res://weapons/rocket_launcher.tscn"),
}
var weapons = {}  # Changed to dictionary for tracking individual weapons

func _ready():
	randomize()
	spawn_bear()
	spawn_bear()
	spawn_bear()
	spawn_all_weapons()
	_on_language_changed()

# Updates text for all nodes in the "translatable" group according to the current language settings from the LanguageManager.
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

# Spawns all weapon types at random positions within the game viewport, ensuring each weapon type is represented multiple times.
func spawn_all_weapons():
	for weapon_type in weapon_scenes.keys():
		if not weapons.has(weapon_type) or weapons[weapon_type] == null:
			for idx in range(12):
				spawn_weapon(weapon_type,idx)

# Instantiates a weapon of the specified type at a random position within the game viewport and tracks it in the weapons dictionary.
func spawn_weapon(weapon_type, index):
	var weapon_scene = weapon_scenes[weapon_type]
	if weapon_scene == null:
		print("Weapon scene not loaded for: ", weapon_type)
		return
	var weapon = weapon_scene.instantiate()
	var subviewport = get_node("CanvasLayer/ColorRect/SubViewport")
	var x_pos = randf() * subviewport.size.x - subviewport.size.x/2
	var y_pos = randf() * subviewport.size.y - subviewport.size.y/2
	print("Viewport size", subviewport.size.x)
	weapon.position = Vector2(x_pos, y_pos)
	add_child(weapon)
	weapons[weapon_type+"___"+str(index)] = {"instance": weapon, "timeout": 15.0}

# Updates the game state each frame, particularly managing weapon timeouts and respawning weapons as necessary.
func _process(delta):
	var to_remove = []
	for weapon_type in weapons.keys():
		if weapons[weapon_type] != null:
			var weapon_info = weapons[weapon_type]
			weapon_info.timeout -= delta
			if weapon_info.timeout <= 0:
				weapon_info["instance"].queue_free()
				to_remove.append(weapon_type)
	for weapon_type in to_remove:
		weapons.erase(weapon_type)
		get_node("/root/gameLevel/playerFox").canPick = true
		var split = weapon_type.split("___")
		var type = split[0]
		var idx = split[1]
		spawn_weapon(type,idx)  # Re-spawn the weapon

# Spawns a normal bear enemy at a random position along a predefined path (Path 2D).
func spawn_bear():
	var new_bear = preload("res://Characters/enemy_bear.tscn").instantiate()
	%PathFollow2D.progress_ratio = randf()
	new_bear.global_position = %PathFollow2D.global_position
	add_child(new_bear)

# Spawns a big bear enemy at a random position along a predefined path (Path 2D).
func spawn_bear_big():
	var new_bear_big = preload("res://Characters/enemy_bear_big.tscn").instantiate()
	%PathFollow2D.progress_ratio = randf()
	new_bear_big.global_position = %PathFollow2D.global_position
	add_child(new_bear_big)

# Spawns a gunman bear enemy at a random position along a predefined path (Path 2D).
func spawn_bear_gunman():
	var new_bear_gunman = preload("res://Characters/enemy_bear_gunman.tscn").instantiate()
	%PathFollow2D.progress_ratio = randf()
	new_bear_gunman.global_position = %PathFollow2D.global_position
	add_child(new_bear_gunman)

# Spawns a normal bear enemy every second when the timer expires.
func _on_timer_timeout():
	spawn_bear()

# Spawns a big bear enemy every 3 seconds when the timer expires.
func _on_timer_big_timeout():
	spawn_bear_big()

# Spawns a gunman bear enemy every 2 seconds when the timer expires.
func _on_timer_gunman_timeout():
	spawn_bear_gunman()

# pause the game and show the "you are dead" layer when player_fox has 0 health 
func _on_player_fox_fox_health_depleted():
	%gameOver.visible = true
	get_tree().paused = true

# pause the game and show the "you are dead" layer when the farm has 0 health 
func _on_static_body_2d_health_depleted():
	%gameOver.visible = true
	get_tree().paused = true

# Restarts the current scene when the "Play Again" button is pressed, resuming the game.
func _on_play_again_pressed():
	button_click.play()
	get_tree().paused = false
	get_tree().reload_current_scene()

# Returns to the main menu scene when the "Go to Main Menu" button is pressed, resuming the game.
func _on_go_main_menu_pressed():
	button_click.play()
	get_tree().paused = false
	get_tree().change_scene_to_file("res://views/menu.tscn")

# Resumes the game from a paused state and hides the pause menu.
func _on_resume_game_pressed():
	button_click.play()
	get_tree().paused = false
	%pauseMenu.visible = false

# Restarts the current scene when the "Restart Game" button is pressed, resuming the game.
func _on_restart_game_pressed():
	button_click.play()
	get_tree().paused = false
	get_tree().reload_current_scene()

# Pauses the game and shows the pause menu when the "Pause" button is pressed.
func _on_pause_button_pressed():
	button_click.play()
	get_tree().paused = true
	%pauseMenu.visible = true




func _on_game_timer_ready():
	game_label.text=game_timer
