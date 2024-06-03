# This file is for the functions of rocket launcher 
extends Area2D

var picked = false
var fire_rate = 0.1
var can_fire = true

@onready var animation_tree : AnimationTree = $AnimationTree
@onready var rocket_shot = $rocketShot
@onready var rocket_pickup = $rocketPickup

func _ready():
	animation_tree.active = true
# for automatic aiming when enemies are in the range 
func _physics_process(delta):
	var enemies_in_range = get_overlapping_bodies()
	if enemies_in_range.size() > 0:
		var target_enemy = enemies_in_range.front()
		#look_at(target_enemy.global_position)
	
	if picked == true:
		# the weapon goes to the pre-set position when it is picked up by player 
		self.global_position = get_node("/root/gameLevel/playerFox/rocketLauncherPosition").global_position
# generate new bullets at the shootingPoint, "can_fire" used to control fire rate	
func shoot():
	const ROCKET_BULLET = preload("res://Weapons/rocket_launcher_bullet.tscn")
	var new_rocketlauncher_bullet = ROCKET_BULLET.instantiate()
	new_rocketlauncher_bullet.global_position = %rocketLauncherShootingPoint.global_position
	new_rocketlauncher_bullet.global_rotation = %rocketLauncherShootingPoint.global_rotation
	%rocketLauncherShootingPoint.add_child(new_rocketlauncher_bullet)
	can_fire = false
	await get_tree().create_timer(fire_rate). timeout
	can_fire = true
	rocket_shot.play()

func _input(event):
	# use input "ui_pick" to be picked up by player 
	if Input. is_action_just_pressed("ui_pick"):
		var bodies = $playerDetector.get_overlapping_bodies()
		for body in bodies:
			# only player can pick up weapon
			if body.name == "playerFox" and get_node("/root/gameLevel/playerFox").canPick == true:
				picked = true
				# after picking up a weapon, canPick will be set to false  
				get_node("/root/gameLevel/playerFox").canPick = false
				rocket_pickup.play()
	# use input "ui_drop" to be dropped by player 			
	if Input. is_action_just_pressed("ui_drop") and picked == true:
		picked = false
		# after dropping a weapon, canPick will be set to true
		get_node("/root/gameLevel/playerFox").canPick = true
		
func _process(delta):
	update_animtaion_parameters()
	# after picking up the waepon, it looks at the mouse position 
	if picked == true: 
		look_at(get_global_mouse_position())
	# if the weapon is picked and can fire and the "fire" button is pressed, it fires 	
	if Input. is_action_just_pressed("fire") and can_fire and picked == true:
		shoot()
		
# for shooting based on timer, using timer to adjust fire rate 		
#func _on_timer_timeout():
	#if picked == true:
		#shoot()
		
# if the input "fire" is triggered, play the fire animation, otherwise not play
func update_animtaion_parameters():
	if(Input.is_action_pressed("fire") and picked == true):
		animation_tree["parameters/conditions/fire"] = true
		animation_tree["parameters/conditions/idle"] = false
	else:
		animation_tree["parameters/conditions/fire"] = false
		animation_tree["parameters/conditions/idle"] = true
