extends Node2D
	
func _ready():
	spawn_bear()
	spawn_bear()
	spawn_bear()
	
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
