extends Area2D

#var picked = false
#var fire_rate = 0.1
#var can_fire = true

@onready var animation_tree : AnimationTree = $AnimationTree
@onready var player = get_node("/root/gameLevel/playerFox")
# @onready var player = get_node("/root/gameLevel/farm")

func _ready():
	animation_tree.active = true

func _physics_process(delta):
	var enemies_in_range = get_overlapping_bodies()
	if enemies_in_range.size() > 0:
		var target_enemy = enemies_in_range.front()
		look_at(player.global_position)
	
	#if picked == true:
		#self.position = get_node("/root/gameLevel/playerFox/riflePosition").global_position
		
func shoot():
	const RIFLE_BULLET = preload("res://Weapons/rifle_bullet_enemy.tscn")
	var new_rifle_bullet = RIFLE_BULLET.instantiate()
	new_rifle_bullet.global_position = %rifleShootingPoint.global_position
	new_rifle_bullet.global_rotation = %rifleShootingPoint.global_rotation
	%rifleShootingPoint.add_child(new_rifle_bullet)
	#can_fire = false
	#await get_tree().create_timer(fire_rate). timeout
	#can_fire = true
	
#func _input(event):
	#if Input. is_action_just_pressed("ui_pick"):
		#var bodies = $playerDetector.get_overlapping_bodies()
		#for body in bodies:
			#if body.name == "playerFox" and get_node("/root/gameLevel/playerFox").canPick == true:
				#picked = true
				#get_node("/root/gameLevel/playerFox").canPick = false
				
	#if Input. is_action_just_pressed("ui_drop") and picked == true:
		#picked = false
		#get_node("/root/gameLevel/playerFox").canPick = true
		
#func _process(delta):
	#update_animtaion_parameters()
	
	#if picked == true: 
		#look_at(get_global_mouse_position())
		
	#if Input. is_action_pressed("fire") and can_fire and picked == true:
		#shoot()
		
func _on_timer_timeout():
	#if picked == true:
		shoot()
		
#func update_animtaion_parameters():
	#if(Input.is_action_pressed("fire") and picked == true):
		#animation_tree["parameters/conditions/fire"] = true
		#animation_tree["parameters/conditions/idle"] = false
	#else:
		#animation_tree["parameters/conditions/fire"] = false
		#animation_tree["parameters/conditions/idle"] = true
