extends CharacterBody2D

signal fox_health_depleted

@export var move_speed : float = 100
@export var starting_direction : Vector2 = Vector2(0,1)

@onready var animation_tree = $AnimationTree
@onready var state_machine = animation_tree.get("parameters/playback")

var health = 100.0 
var canPick = true

func _ready():
	update_animation_parameters(starting_direction)
	
func take_damage():
	health -= 5.0
	
func _physics_process(_delta):
	#Get input direction
	var input_direction = Vector2(
		Input.get_action_strength("right") - Input.get_action_strength("left"),
		Input.get_action_strength("down") - Input.get_action_strength("up")
		)
	
	update_animation_parameters(input_direction)
	
	#Update velocity
	velocity = input_direction * move_speed
	
	move_and_slide()
	
	pick_new_state()
	
	const DAMAGE_RATE = 10.0
	var overlapping_bears = %foxHurtBox.get_overlapping_bodies()
	if overlapping_bears.size() > 0:
		health -= DAMAGE_RATE * overlapping_bears.size() * _delta
		
	%ProgressBar.value = health
	if health <= 0.0:
		fox_health_depleted.emit()
			
	
func update_animation_parameters(move_input : Vector2):
	if(move_input != Vector2.ZERO):
		animation_tree.set("parameters/walking/blend_position", move_input)
		animation_tree.set("parameters/idle/blend_position", move_input)
		
func pick_new_state():
	if(velocity != Vector2.ZERO):
		state_machine.travel("walking")
	else:
		state_machine.travel("idle")
		
