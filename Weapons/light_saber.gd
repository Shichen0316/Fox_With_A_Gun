extends Area2D

var picked = false

@onready var animation_tree : AnimationTree = $AnimationTree

func _ready():
	animation_tree.active = true
	
	# the weapon goes to the pre-set position when it is picked up by player 
func _physics_process(delta):
	if picked == true:
		self.position = get_node("/root/gameLevel/playerFox/lightsaberPosition").global_position

func _input(event):
	# use input "ui_pick" to be picked up by player 
	if Input. is_action_just_pressed("ui_pick"):
		var bodies = $playerDetector.get_overlapping_bodies()
		for body in bodies:
			# only player can pick up weapon 
			if body.name == "playerFox" and get_node("/root/gameLevel/playerFox").canPick == true:
				# after picking up a weapon, canPick will be set to false  
				picked = true
				get_node("/root/gameLevel/playerFox").canPick = false
	
	# use input "ui_drop" to be dropped by player 
	if Input. is_action_just_pressed("ui_drop") and picked == true:
		# after dropping a weapon, canPick will be set to true
		picked = false
		get_node("/root/gameLevel/playerFox").canPick = true

func _process(delta):
	update_animtaion_parameters()
	
	# after picking up the waepon, it looks at the mouse position 
	if picked == true: 
		look_at(get_global_mouse_position())
		
	# when collision shape touches the collision shape of a bear, check if it has "take_high_damage" function, if true, trigger it 
func _on_body_entered(body):
	if body.has_method("take_high_damage"):
		body.take_high_damage()
		
	# if the input "fire" is triggered, play the fire animation 
func update_animtaion_parameters():
	if(Input.is_action_pressed("fire") and picked == true):
		animation_tree["parameters/conditions/fire"] = true
	else:
		animation_tree["parameters/conditions/fire"] = false
