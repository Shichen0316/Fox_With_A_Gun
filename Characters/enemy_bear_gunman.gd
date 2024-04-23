extends CharacterBody2D

var health = 5.0

# the bear goes to the position of the player  
@onready var player = get_node("/root/gameLevel/playerFox")
# the bear goes to the position of the farm 
# @onready var player = get_node("/root/gameLevel/farm")

@onready var animation_tree : AnimationTree = $AnimationTree

var direction : Vector2 = Vector2.ZERO

func _ready():
	animation_tree.active = true
	
func _process(delta):
	update_animtaion_parameters()

func _physics_process(delta):
	var direction = global_position.direction_to(player.global_position)
	velocity = direction * 100.0
	move_and_slide()

# take a demage of 5 
func take_high_damage():
	health -= 5
	# if health is 0, disspear 
	if health == 0:
		queue_free()

# take a demage of 1 		
func take_damage():
	health -= 1
	# if health is 0, disspear 
	if health == 0:
		queue_free()
		
func update_animtaion_parameters():
	if(velocity == Vector2.ZERO):
		animation_tree["parameters/conditions/attacking"] = true
		animation_tree["parameters/conditions/walking"] = false
	else:
		animation_tree["parameters/conditions/attacking"] = false
		animation_tree["parameters/conditions/walking"] = true
	
	animation_tree["parameters/walking 2/blend_position"] = direction
	animation_tree["parameters/attacking/blend_position"] = direction
	
