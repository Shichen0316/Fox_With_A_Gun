# This file is for the movement, health, and animation for big enemy bear 
extends CharacterBody2D

var health = 15.0

# player is the fox, the bear goes to the position of the player  
# @onready var player = get_node("/root/gameLevel/playerFox")
# player is the farm, the bear goes to the position of the farm 
@onready var player = get_node("/root/gameLevel/farm")

@onready var animation_tree : AnimationTree = $AnimationTree

var direction : Vector2 = Vector2.ZERO

func _ready():
	animation_tree.active = true
	
func _process(delta):
	update_animtaion_parameters()

func _physics_process(delta):
	# bear goes to the direction of the palyer, which is set above 
	var direction = global_position.direction_to(player.global_position)
	# speed of the bear: 50 
	velocity = direction * 50.0
	move_and_slide()
	
# take a demage of 7.5, works for light saber and rocket launcher 
func take_high_damage():
	health -= 7.5
	# if health is 0, disappear 
	if health == 0:
		queue_free()
		
# take a damage of 1, works for pistol, rifle, lasergun, shotgun 
func take_damage():
	health -= 1
	# if health is 0, disappear 
	if health == 0:
		queue_free()

# update the animations when movement status is changed 				
func update_animtaion_parameters():
	if(velocity == Vector2.ZERO):
		animation_tree["parameters/conditions/attacking"] = true
		animation_tree["parameters/conditions/walking"] = false
	else:
		animation_tree["parameters/conditions/attacking"] = false
		animation_tree["parameters/conditions/walking"] = true
	
	animation_tree["parameters/walking/blend_position"] = direction
	animation_tree["parameters/attacking/blend_position"] = direction
	
