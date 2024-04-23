extends Sprite2D

#func play_walking():
	#%AnimationPlayer.play("bear_walking_right")
	
#func play_attacking():
	#%AnimationPlayer.play("attack")
	#%AnimationPlayer.queue("walk")
