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
		if not weapons.has(weapon_type) or weapons[weapon_type] == null:
			for idx in range(200):
				spawn_weapon(weapon_type,idx)

func spawn_weapon(weapon_type, index):
	var weapon_scene = weapon_scenes[weapon_type]
	if weapon_scene == null:
		print("Weapon scene not loaded for: ", weapon_type)
		return

	var weapon = weapon_scene.instantiate()
	var subviewport = get_node("CanvasLayer/ColorRect/SubViewport")
	var x_pos = randf() * subviewport.size.x - subviewport.size.x/2
	var y_pos = randf() * subviewport.size.y - subviewport.size.y/2
	#var x_pos = randf() * get_viewport_rect().size.x
	#var y_pos = randf() * get_viewport_rect().size.y
	print("Viewport size", subviewport.size.x)
	weapon.position = Vector2(x_pos, y_pos)
	add_child(weapon)
	weapons[weapon_type+"___"+str(index)] = {"instance": weapon, "timeout": 10.0}

#func set_weapon_timeout(weapon_type):
	## Create a timer and wait for it to timeout
	#var timer = get_tree().create_timer(10.0)
	#await timer.timeout
	#print("timeout finished")
	## Check if the weapon still exists before trying to queue_free it
	#if weapons.has(weapon_type) and weapons[weapon_type] != null:
	##if weapon_info["instance"] and not weapon_info["instance"].is_queued_for_deletion():
		#weapons[weapon_type].queue_free()
		#weapons[weapon_type] = null
	#print("spawning weapon")
	#spawn_weapon(weapon_type)

func _process(delta):
	var to_remove = []
	print("keys",weapons.values())
	for weapon_type in weapons.keys():
		if weapons[weapon_type] != null:
			var weapon_info = weapons[weapon_type]
			weapon_info.timeout -= delta
			if weapon_info.timeout <= 0:
				weapon_info["instance"].queue_free()
				to_remove.append(weapon_type)
	for weapon_type in to_remove:
		weapons.erase(weapon_type)
		
		var split = weapon_type.split("___")
		var type = split[0]
		var idx = split[1]
		
		spawn_weapon(type,idx)  # Re-spawn the weapon

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
