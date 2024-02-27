extends Node

signal score_added
signal cleared

var scores: Dictionary

func _enter_tree():
	load_from_disk()

func _exit_tree():
	save_to_disk()

func load_from_disk():
	if not FileAccess.file_exists("user://scores.sb"):
		return
	
	var file = FileAccess.open("user://scores.sb", FileAccess.READ)
	scores = file.get_var()
	file.close()

func save_to_disk():
	if FileAccess.file_exists("user://scores.sb"):
		if FileAccess.file_exists("user://scores_backup.sb"):
			DirAccess.remove_absolute("user://scores_backup.sb")
		DirAccess.rename_absolute("user://scores.sb", "user://scores_backup.sb")
	
	var file = FileAccess.open("user://scores.sb", FileAccess.WRITE)
	file.store_var(scores)
	file.close()

func add_score(username: String, score: String):
	scores[username] = score
	score_added.emit()

func clear():
	scores.clear()
	cleared.emit()
