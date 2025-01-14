# This file is for the functions of lasergun 
extends Area2D

var picked = false
var fire_rate = 0.001
var can_fire = true

@onready var animation_tree : AnimationTree = $AnimationTree
@onready var laser_shot = $laserShot
@onready var laser_pickup = $laserPickup


func _ready():
	animation_tree.active = true
	print("Node Type: ", get_class())
	
func _physics_process(delta):
	var enemies_in_range = get_overlapping_bodies()
	if enemies_in_range.size() > 0:
		var target_enemy = enemies_in_range.front()
		#look_at(target_enemy.global_position)
	# after picked, it goes to a set position next to the player 
	if picked == true:
		self.global_position = get_node("/root/gameLevel/playerFox/lasergunPosition").global_position
# generate new bullet when firing, timer is to manage fire rate 		
func shoot():
	const LASERGUN_BULLET = preload("res://Weapons/lasergun_bullet.tscn")
	var new_lasergun_bullet = LASERGUN_BULLET.instantiate()
	new_lasergun_bullet.global_position = %lasergunShootingPoint.global_position
	new_lasergun_bullet.global_rotation = %lasergunShootingPoint.global_rotation
	%lasergunShootingPoint.add_child(new_lasergun_bullet)
	can_fire = false
	await get_tree().create_timer(fire_rate). timeout
	can_fire = true
	laser_shot.play()
# press ui_pick to pick the weapon from the ground 	
func _input(event):
	if Input. is_action_just_pressed("ui_pick"):
		var bodies = $playerDetector.get_overlapping_bodies()
		for body in bodies:
			if body.name == "playerFox" and get_node("/root/gameLevel/playerFox").canPick == true:
				picked = true
				get_node("/root/gameLevel/playerFox").canPick = false
				laser_pickup.play()
	# press ui_drop to drop the weapon 			
	if Input. is_action_just_pressed("ui_drop") and picked == true:
		picked = false
		get_node("/root/gameLevel/playerFox").canPick = true
		
		
func _process(delta):
	update_animtaion_parameters()
	# weapon points at the mouse 
	if picked == true: 
		look_at(get_global_mouse_position())
		# shoot when all the premises are met 
	if Input. is_action_pressed("fire") and can_fire and picked == true:
		shoot()
		
#func _on_timer_timeout():
	#if picked == true:
		#shoot()
# play animation when firing 		
func update_animtaion_parameters():
	if(Input.is_action_pressed("fire") and picked == true):
		animation_tree["parameters/conditions/fire"] = true
		animation_tree["parameters/conditions/idle"] = false
	else:
		animation_tree["parameters/conditions/fire"] = false
		animation_tree["parameters/conditions/idle"] = true
	
	
