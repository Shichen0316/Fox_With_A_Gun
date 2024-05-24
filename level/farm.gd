# This file manages the health of the base during the gameplay.
extends Area2D

signal health_depleted

var health = 100.0

# Decreases the health by 1 each time it's called.
func take_damage():
	health -= 1

# If the farm has overlapping collision bodies on it, it takes damage at the rate of 0.5 per overlapping body per frame.
func _physics_process(delta):
	const DAMAGE_RATE = 0.5
	var overlapping_bears = %hurtBox.get_overlapping_bodies()
	if overlapping_bears.size() > 0:
		health -= DAMAGE_RATE * overlapping_bears.size() * delta
		%ProgressBar.value = health 
		# if the health is 0, siginal health_depleted is sent 
		if health <= 0.0:	
			health_depleted.emit()
