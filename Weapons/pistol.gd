extends Area2D

var picked = false
var fire_rate = 0.1
var can_fire = true

@onready var animation_tree : AnimationTree = $AnimationTree
@onready var gun_shot = $gunShot
@onready var gun_pickup = $gunPickup

func _ready():
	animation_tree.active = true

func _physics_process(delta):
# for automatic aiming when enemies are in the range 
	#var enemies_in_range = get_overlapping_bodies()
	#if enemies_in_range.size() > 0:
		#var target_enemy = enemies_in_range.front()
		#look_at(target_enemy.global_position)
	
	# the weapon goes to the pre-set position when it is picked up by player 
	if picked == true:
		self.global_position = get_node("/root/gameLevel/playerFox/pistolPosition").global_position

# generate new bullets at the shootingPoint, "can_fire" used to control fire rate 
func shoot():
	const BULLET = preload("res://Weapons/bullet.tscn")
	var new_bullet = BULLET.instantiate()
	new_bullet.global_position = %shootingPoint.global_position
	new_bullet.global_rotation = %shootingPoint.global_rotation
	%shootingPoint.add_child(new_bullet)
	can_fire = false
	await get_tree().create_timer(fire_rate). timeout
	can_fire = true
	gun_shot.play()

func _input(event):
	# use input "ui_pick" to be picked up by player 
	if Input. is_action_just_pressed("ui_pick"):
		var bodies = $playerDetector.get_overlapping_bodies()
		for body in bodies:
			# only player can pick up weapon 
			if body.name == "playerFox" and get_node("/root/gameLevel/playerFox").canPick == true:
				picked = true
				gun_pickup.play()
				# after picking up a weapon, canPick will be set to false  
				get_node("/root/gameLevel/playerFox").canPick = false
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
	if Input. is_action_pressed("fire") and can_fire and picked == true:
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
