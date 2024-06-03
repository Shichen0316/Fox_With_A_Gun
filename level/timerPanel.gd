extends Panel
#This file handles the timer on the topleft which also works as the score for the screen in the game. 


var time: float = 0.0
var minutes: int = 0
var seconds: int = 0
var msec: int = 0

# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta) -> void:
	time += delta
	msec = fmod(time, 1) * 100
	seconds = fmod(time, 60)
	minutes = fmod(time, 3600) / 60
	$Minutes.text = "%02d:" % minutes
	$Seconds.text = "%02d." % seconds
	$mSeconds.text = "%02d" % msec



#Below functions not used. Would be used if we wanted to display the time in another way or export it. 

#func stop() -> void:
	#set_process(false)

#func get_time_formatted() -> String:
	#return "%02d:%02d.%03d" % [minutes, seconds, msec]
