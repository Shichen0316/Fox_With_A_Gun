extends Area2D

var bullet_distance = 0

func _physics_process(delta):
	# flying speed of the bullet: 500
	const SPEED = 200.0
	# flying range of the bullet: 1000
	const RANGE = 500.0
	var direction = Vector2.RIGHT.rotated(rotation)
	position += direction * SPEED * delta
	
	bullet_distance += SPEED * delta
	# bullet disappears when it flys off the range 
	if bullet_distance > RANGE: queue_free()

# when the bullet enter the player body
func _on_body_entered(body):
	# it disappears 
	queue_free()
	# if the player has "take_damage" function, trigger it 
	if body.has_method("take_damage"):
		body.take_damage()
