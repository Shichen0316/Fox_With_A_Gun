extends Area2D

var picked = false
var fire_rate = 0.1
var can_fire = true

@onready var animation_tree : AnimationTree = $AnimationTree

func _ready():
	animation_tree.active = true

func _physics_process(delta):
	var enemies_in_range = get_overlapping_bodies()
	if enemies_in_range.size() > 0:
		var target_enemy = enemies_in_range.front()
		#look_at(target_enemy.global_position)
	
	if picked == true:
		self.position = get_node("/root/gameLevel/playerFox/shotgunPosition").global_position
		
func shoot():
	const RIFLE_BULLET = preload("res://Weapons/rifle_bullet.tscn")
	var new_rifle_bullet1 = RIFLE_BULLET.instantiate()
	var new_rifle_bullet2 = RIFLE_BULLET.instantiate()
	var new_rifle_bullet3 = RIFLE_BULLET.instantiate()
	var new_rifle_bullet4 = RIFLE_BULLET.instantiate()
	var new_rifle_bullet5 = RIFLE_BULLET.instantiate()
	var new_rifle_bullet6 = RIFLE_BULLET.instantiate()
	new_rifle_bullet1.global_position = %shotgunShootingPoint1.global_position
	new_rifle_bullet1.global_rotation = %shotgunShootingPoint1.global_rotation
	new_rifle_bullet2.global_position = %shotgunShootingPoint2.global_position
	new_rifle_bullet2.global_rotation = %shotgunShootingPoint2.global_rotation
	new_rifle_bullet3.global_position = %shotgunShootingPoint3.global_position
	new_rifle_bullet3.global_rotation = %shotgunShootingPoint3.global_rotation
	new_rifle_bullet4.global_position = %shotgunShootingPoint4.global_position
	new_rifle_bullet4.global_rotation = %shotgunShootingPoint4.global_rotation
	new_rifle_bullet5.global_position = %shotgunShootingPoint5.global_position
	new_rifle_bullet5.global_rotation = %shotgunShootingPoint5.global_rotation
	new_rifle_bullet6.global_position = %shotgunShootingPoint6.global_position
	new_rifle_bullet6.global_rotation = %shotgunShootingPoint6.global_rotation
	%shotgunShootingPoint1.add_child(new_rifle_bullet1)
	%shotgunShootingPoint2.add_child(new_rifle_bullet2)
	%shotgunShootingPoint3.add_child(new_rifle_bullet3)
	%shotgunShootingPoint4.add_child(new_rifle_bullet4)
	%shotgunShootingPoint5.add_child(new_rifle_bullet5)
	%shotgunShootingPoint6.add_child(new_rifle_bullet6)
	can_fire = false
	await get_tree().create_timer(fire_rate). timeout
	can_fire = true
	
func _input(event):
	if Input. is_action_just_pressed("ui_pick"):
		var bodies = $playerDetector.get_overlapping_bodies()
		for body in bodies:
			if body.name == "playerFox" and get_node("/root/gameLevel/playerFox").canPick == true:
				picked = true
				get_node("/root/gameLevel/playerFox").canPick = false
				
	if Input. is_action_just_pressed("ui_drop") and picked == true:
		picked = false
		get_node("/root/gameLevel/playerFox").canPick = true
		
func _process(delta):
	update_animtaion_parameters()
	
	if picked == true: 
		look_at(get_global_mouse_position())
		
	if Input. is_action_just_pressed("fire") and can_fire and picked == true:
		shoot()
		
#func _on_timer_timeout():
	#if picked == true:
		#shoot()
		
func update_animtaion_parameters():
	if(Input.is_action_pressed("fire") and picked == true):
		animation_tree["parameters/conditions/fire"] = true
		animation_tree["parameters/conditions/idle"] = false
	else:
		animation_tree["parameters/conditions/fire"] = false
		animation_tree["parameters/conditions/idle"] = true
