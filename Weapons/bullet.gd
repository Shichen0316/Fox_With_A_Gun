extends Area2D

var bullet_distance = 0

func _physics_process(delta):
	const SPEED = 300.0
	const RANGE = 500.0
	var direction = Vector2.RIGHT.rotated(rotation)
	position += direction * SPEED * delta
	
	bullet_distance += SPEED * delta
	if bullet_distance > RANGE: queue_free()


func _on_body_entered(body):
	queue_free()
	if body.has_method("take_damage"):
		body.take_damage()
