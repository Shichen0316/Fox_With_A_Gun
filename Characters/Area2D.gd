extends Area2D

var animation_player

func _ready():
	animation_player = $AnimationPlayer # Assuming your AnimationPlayer node is named "AnimationPlayer"

# This function is called when a body enters the collision area
func _on_body_entered(body):
	if body.name == "res://Level/farm_collision.tscn":
		print("Collision detected with OtherObject")
		animation_player.play("bear_attacking_right")
