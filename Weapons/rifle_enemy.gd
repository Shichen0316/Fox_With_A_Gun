extends Area2D

@onready var animation_tree : AnimationTree = $AnimationTree
# player is the fox, weapon aims the player 
@onready var player = get_node("/root/gameLevel/playerFox")
# @onready var player = get_node("/root/gameLevel/farm")

func _ready():
	animation_tree.active = true

func _physics_process(delta):
# for automatic aiming when player is in the range 
	var enemies_in_range = get_overlapping_bodies()
	if enemies_in_range.size() > 0:
		var target_enemy = enemies_in_range.front()
		# aim player 
		look_at(player.global_position)

# generate new bullets at the shootingPoint, timer used to control fire rate
func shoot():
	const RIFLE_BULLET = preload("res://Weapons/rifle_bullet_enemy.tscn")
	var new_rifle_bullet = RIFLE_BULLET.instantiate()
	new_rifle_bullet.global_position = %rifleShootingPoint.global_position
	new_rifle_bullet.global_rotation = %rifleShootingPoint.global_rotation
	%rifleShootingPoint.add_child(new_rifle_bullet)
		
func _on_timer_timeout():
		shoot()

#func _process(delta):
	#update_animtaion_parameters()
	
#func update_animtaion_parameters():
	#if(Input.is_action_pressed("fire") and picked == true):
		#animation_tree["parameters/conditions/fire"] = true
		#animation_tree["parameters/conditions/idle"] = false
	#else:
		#animation_tree["parameters/conditions/fire"] = false
		#animation_tree["parameters/conditions/idle"] = true
