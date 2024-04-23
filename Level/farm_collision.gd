extends StaticBody2D

signal health_depleted

var health = 500.0

func take_damage():
	health -= 0.5

func _physics_process(delta):
	const DAMAGE_RATE = 0.5
	var overlapping_bears = %hurtBox.get_overlapping_bodies()
	if overlapping_bears.size() > 0:
		health -= DAMAGE_RATE * overlapping_bears.size() * delta
		%ProgressBar.value = health 
		if health <= 0.0:	
			health_depleted.emit()	
