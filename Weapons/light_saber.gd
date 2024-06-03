# This file is for the functions of light saber 
extends Area2D

var picked = false

@onready var animation_tree : AnimationTree = $AnimationTree
@onready var pickup_sound = $pickupSound
@onready var passive_sound = $passiveSound


func _ready():
	animation_tree.active = true
# the weapon goes to the pre-set position when it is picked up by player 	
func _physics_process(delta):
	if picked == true:
		self.global_position = get_node("/root/gameLevel/playerFox/lightsaberPosition").global_position
# use input "ui_pick" to be picked up by player 
func _input(event):
	if Input. is_action_just_pressed("ui_pick"):
		var bodies = $playerDetector.get_overlapping_bodies()
		for body in bodies:
			# only player can pick up weapon 
			if body.name == "playerFox" and get_node("/root/gameLevel/playerFox").canPick == true:
				picked = true
				# after picking up a weapon, canPick will be set to false  
				get_node("/root/gameLevel/playerFox").canPick = false
				pickup_sound.play()
	# use input "ui_drop" to be dropped by player			
	if Input. is_action_just_pressed("ui_drop") and picked == true:
		picked = false
		get_node("/root/gameLevel/playerFox").canPick = true

func _process(delta):
	update_animtaion_parameters()
	# weapon points to the mouse position 
	if picked == true: 
		look_at(get_global_mouse_position())
		
# if the light saber touches bear, it takes damage 		
func _on_body_entered(body):
	if body.has_method("take_high_damage"):
		body.take_high_damage()
# if the input "fire" is triggered, play the fire animation, otherwise not play 		
func update_animtaion_parameters():
	if(Input.is_action_pressed("fire") and picked == true):
		animation_tree["parameters/conditions/fire"] = true
		passive_sound.play()
	else:
		animation_tree["parameters/conditions/fire"] = false
