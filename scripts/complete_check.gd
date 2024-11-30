extends Node2D

@onready var main:= get_parent()

signal complete_check_finished

func _checking():
	var completed_count = 0
	
	for codename in GlobalData.codename_arr:
		if GlobalData.collection_arr.has(codename):
			completed_count += 1
	
	if completed_count >= 26:
		if GlobalData.collection_arr.has("ex_misprint"):
			completed_count += 1
		if GlobalData.collection_arr.has("ex_promo"):
			completed_count += 1
		if GlobalData.collection_arr.has("ex_driver"):
			completed_count += 1
		if GlobalData.collection_arr.has("ex_credit"):
			completed_count += 1
	
	if GlobalData.completed == false:
		if completed_count == 26:
			main.binder_open = true
			main.binder._first_completed(26)
		elif completed_count == 27:
			main.binder_open = true
			main.binder._first_completed(27)
		elif completed_count == 28:
			main.binder_open = true
			main.binder._first_completed(28)
		elif completed_count == 29:
			main.binder_open = true
			main.binder._first_completed(29)
		elif completed_count == 30:
			main.binder_open = true
			main.binder._first_completed(30)
	else:
		main.binder._update_completed(completed_count)
	
	complete_check_finished.emit()
