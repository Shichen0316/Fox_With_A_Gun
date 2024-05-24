#extends Node
#
#var time_survived = 0.0  # Tracks the total time survived in seconds
#var score_timer = Timer.new()  # Timer for updating the score every second
#
#func _ready():
	## Initialize the score timer
	#score_timer.wait_time = 1  # Update score every second
	#score_timer.autostart = true
	#score_timer.one_shot = false
	#score_timer.timeout.connect(_on_score_timer_timeout)
	#add_child(score_timer)
	#score_timer.start()
	#update_score_display()
#
#func update_score_display():
	#$Score.text = "Time: %d" % int(time_survived)
#
#func _on_score_timer_timeout():
	## Increment the time survived every second
	#time_survived += 1
	#update_score_display()
