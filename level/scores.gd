# This file takes care of displaying the player's score. The score is the time until the player survived.
extends CanvasLayer

var survival_time: float = 0.0
@onready var survival_time_label = $survivalTimeCount
@onready var timer = $Timer

func _ready():
	timer.set_wait_time(1.0)  # The timer will tick every second
	#timer.connect("timeout", self, "_on_Timer_timeout")
	timer.timeout.connect(_on_Timer_timeout)
	timer.start()
	update_survival_time()

func _process(delta):
	survival_time += delta
	update_survival_time()

func update_survival_time():
	if survival_time_label is Label:
		survival_time_label.text = "Survival Time: " + str(int(survival_time)) + "s"

func _on_Timer_timeout():
	# This function can be used for any periodic updates
	pass

#func save_score():
	#var scores = []
	#var file = File.new()
	#if file.file_exists("user://scores.save"):
		#file.open("user://scores.save", File.READ)
		#scores = file.get_var()
		#file.close()
	#file.open("user://scores.save", File.WRITE)
	#scores.append(int(survival_time))
	#scores.sort()
	#scores.reverse()
	#file.store_var(scores)
	#file.close()
#
#func load_scores():
	#var file = File.new()
	#if file.file_exists("user://scores.save"):
		#file.open("user://scores.save", File.READ)
		#var scores = file.get_var()
		#file.close()
		#return scores
	#return []
#
#func on_game_end():
	#save_score()
	#var scores = load_scores()
	#print("Top scores: ", scores)

func _on_timer_timeout():
	pass # Replace with function body.
