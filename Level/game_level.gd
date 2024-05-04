extends Node2D

var weapon_scenes = {
	"rifle": preload("res://weapons/rifle.tscn"),
	"laser_gun": preload("res://weapons/laser_gun.tscn"),
	"light_saber": preload("res://weapons/light_saber.tscn")
}
var weapons = {}  # Changed to dictionary for tracking individual weapons

func _ready():
	randomize()
	spawn_bear()
	spawn_bear()
	spawn_bear()
	spawn_all_weapons()
	$Language_switcher.text = LanguageManager.get_text("changeLanguage")

func spawn_all_weapons():
	for weapon_type in weapon_scenes.keys():
		print("Checking for weapon type: ", weapon_type)
		while (not weapons.has(weapon_type) or weapons[weapon_type].size() < 2):
			print("Spawning weapon of type: ", weapon_type)
			spawn_weapon(weapon_type)

func spawn_weapon(weapon_type):
	print("Attempting to spawn weapon: ", weapon_type)
	var weapon_scene = weapon_scenes[weapon_type]
	if weapon_scene == null:
		print("Weapon scene not loaded for: ", weapon_type)
		return

	var weapon = weapon_scene.instantiate()
	var position = find_valid_position(weapon_type)
	if position == Vector2():
		print("Failed to find a valid position for: ", weapon_type)
		return  # Avoid spawning if no valid position found

	weapon.position = position
	add_child(weapon)

	if not weapons.has(weapon_type):
		weapons[weapon_type] = []
	weapons[weapon_type].append({"instance": weapon, "timeout": 15.0})
	print("Weapon spawned: ", weapon_type, " at ", position)

func find_valid_position(weapon_type):
	var viewport_size = get_viewport_rect().size
	var min_distance = viewport_size.x / 3
	var position = Vector2()

	for attempts in range(10):  # Attempt up to 10 times to find a suitable location
		position.x = randf() * viewport_size.x
		position.y = randf() * viewport_size.y
		var too_close = false

		for weapon_info in weapons.get(weapon_type, []):
			if position.distance_to(weapon_info["instance"].position) < min_distance:
				too_close = true
				break

		if not too_close:
			return position  # Found a suitable position

	return Vector2()  # Return an empty vector if no suitable position is found

func set_weapon_timeout(weapon_type):
	# Create a timer and wait for it to timeout
	var timer = get_tree().create_timer(10.0)
	await timer.timeout
	# Check if the weapon still exists before trying to queue_free it
	if weapons.has(weapon_type) and weapons[weapon_type] != null:
		weapons[weapon_type].queue_free()
		weapons[weapon_type] = null
	spawn_weapon(weapon_type)

func _process(delta):
	var to_remove = []
	for weapon_type in weapons.keys():
		var weapon_list = weapons[weapon_type]
		for i in range(len(weapon_list) - 1, -1, -1):
			var weapon_info = weapon_list[i]
			weapon_info["timeout"] -= delta  # Correct decrement of timeout
			if weapon_info["timeout"] <= 0:
				weapon_info["instance"].queue_free()  # Properly access the instance to queue_free
				weapon_list.remove_at(i)  # Remove the weapon from the list correctly

		if weapon_list.empty() or weapon_list.size() < 2:
			spawn_weapon(weapon_type)  # Ensure to maintain two instances if needed

	# Clean up weapon types if needed
	for weapon_type in to_remove:
		weapons.erase(weapon_type)
		spawn_weapon(weapon_type)  # Re-spawn the weapon

# spwan normal bears on Path2D 
func spawn_bear():
	var new_bear = preload("res://Characters/enemy_bear.tscn").instantiate()
	%PathFollow2D.progress_ratio = randf()
	new_bear.global_position = %PathFollow2D.global_position
	add_child(new_bear)
	
# spwan big bears on Path2D 
func spawn_bear_big():
	var new_bear_big = preload("res://Characters/enemy_bear_big.tscn").instantiate()
	%PathFollow2D.progress_ratio = randf()
	new_bear_big.global_position = %PathFollow2D.global_position
	add_child(new_bear_big)
	
# spwan gunman bears on Path2D 
func spawn_bear_gunman():
	var new_bear_gunman = preload("res://Characters/enemy_bear_gunman.tscn").instantiate()
	%PathFollow2D.progress_ratio = randf()
	new_bear_gunman.global_position = %PathFollow2D.global_position
	add_child(new_bear_gunman)
	
# spwan normal bears when timeout: 1s
func _on_timer_timeout():
	spawn_bear()
	
# spwan big bears when timeout: 3s
func _on_timer_big_timeout():
	spawn_bear_big()
	
# spwan gunman bears when timeout: 2s
func _on_timer_gunman_timeout():
	spawn_bear_gunman()
	
	
#func _on_farm_health_depleted():
	#%gameOver.visible = true
	#get_tree().paused = truesa


# pause the game and show the "you arer dead" layer when player_fox has 0 health 
func _on_player_fox_fox_health_depleted():
	%youAreDead.visible = true
	get_tree().paused = true

# pause the game and show the "you arer dead" layer when the farm has 0 health 
func _on_static_body_2d_health_depleted():
	%gameOver.visible = true
	get_tree().paused = true

#language manager
func _on_button_pressed():
	if LanguageManager.current_language == "EN":
		LanguageManager.set_language("HU")
	else:
		LanguageManager.set_language("EN")
	$Language_switcher.text = LanguageManager.get_text("changeLanguage")
