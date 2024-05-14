#extends Node
#
#var time_survived = 0.0  # tracks the time the player has survived
#var score = 0  # holds the current score
#
#func _ready():
	#pass # Replace with function body.
#
#
#func _process(delta):
	#time_survived += delta
	#update_score()  
#
#func update_score():
	#score = int(time_survived * 100)  # Converts time to score
	#update_score_display()
#
#func update_score_display():
	#var score_label = get_node("ScoreLabel")  # Adjust the node path as necessary
	#score_label.text = "Score: " + str(score)
#
#func save_score():
	#var file = File.new()
	#if file.open("user://score.save", File.WRITE) == OK:
		#file.store_var(score)
		#file.close()
	#else:
		#print("Failed to open file for writing.")
#
#func load_score():
	#var file = File.new()
	#if file.file_exists("user://score.save"):
		#if file.open("user://score.save", File.READ) == OK:
			#score = file.get_var()
			#file.close()
			#update_score_display()
		#else:
			#print("Failed to open file for reading.")
