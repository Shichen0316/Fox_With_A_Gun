extends Area2D

var picked = false

@onready var animation_tree : AnimationTree = $AnimationTree
@onready var pickup_sound = $pickupSound
@onready var passive_sound = $passiveSound


func _ready():
	animation_tree.active = true
	
func _physics_process(delta):
	if picked == true:
		self.position = get_node("/root/gameLevel/playerFox/lightsaberPosition").global_position

func _input(event):
	if Input. is_action_just_pressed("ui_pick"):
		var bodies = $playerDetector.get_overlapping_bodies()
		for body in bodies:
			if body.name == "playerFox" and get_node("/root/gameLevel/playerFox").canPick == true:
				picked = true
				get_node("/root/gameLevel/playerFox").canPick = false
				pickup_sound.play()
				
	if Input. is_action_just_pressed("ui_drop") and picked == true:
		picked = false
		get_node("/root/gameLevel/playerFox").canPick = true

func _process(delta):
	update_animtaion_parameters()
	
	if picked == true: 
		look_at(get_global_mouse_position())
		
		
func _on_body_entered(body):
	if body.has_method("take_high_damage"):
		body.take_high_damage()
		
func update_animtaion_parameters():
	if(Input.is_action_pressed("fire") and picked == true):
		animation_tree["parameters/conditions/fire"] = true
		passive_sound.play()
	else:
		animation_tree["parameters/conditions/fire"] = false
