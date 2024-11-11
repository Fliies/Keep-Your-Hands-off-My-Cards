extends Control

@onready var main:= get_parent().get_parent()

func _on_addpackto_box_pressed() -> void:
	GlobalData.packcount_box += 1
func _on_addpackto_single_pressed() -> void:
	GlobalData.packcount_single += 1
func _on_test_pressed() -> void:
	print(GlobalData.opening_arr)

#func _seen_count():
	#GlobalData.seen_arr.append(main.card_display.card_stat.card_codename)
func _count_all():
	#if GlobalData.seen_arr.size() != 0:
	$collectedcounter/HBoxContainer/Label.text = str(GlobalData.seen_arr.count("aa"))
	$collectedcounter/HBoxContainer/Label2.text = str(GlobalData.seen_arr.count("bb"))
	$collectedcounter/HBoxContainer/Label3.text = str(GlobalData.seen_arr.count("cc"))
	$collectedcounter/HBoxContainer/Label4.text = str(GlobalData.seen_arr.count("dd"))
	$collectedcounter/HBoxContainer/Label5.text = str(GlobalData.seen_arr.count("ee"))
	$collectedcounter/HBoxContainer/Label6.text = str(GlobalData.seen_arr.count("ff"))
	$collectedcounter/HBoxContainer/Label7.text = str(GlobalData.seen_arr.count("gg"))
	$collectedcounter/HBoxContainer/Label8.text = str(GlobalData.seen_arr.count("hh"))
	$collectedcounter/HBoxContainer/Label9.text = str(GlobalData.seen_arr.count("ii"))
	$collectedcounter/HBoxContainer/Label10.text = str(GlobalData.seen_arr.count("jj"))
	$collectedcounter/HBoxContainer/Label11.text = str(GlobalData.seen_arr.count("kk"))
	$collectedcounter/HBoxContainer/Label12.text = str(GlobalData.seen_arr.count("ll"))
	$collectedcounter/HBoxContainer/Label13.text = str(GlobalData.seen_arr.count("mm"))
	$collectedcounter/HBoxContainer/Label14.text = str(GlobalData.seen_arr.count("nn"))
	$collectedcounter/HBoxContainer/Label15.text = str(GlobalData.seen_arr.count("oo"))
	$collectedcounter/HBoxContainer/Label16.text = str(GlobalData.seen_arr.count("pp"))
	$collectedcounter/HBoxContainer/Label17.text = str(GlobalData.seen_arr.count("qq"))
	$collectedcounter/HBoxContainer/Label18.text = str(GlobalData.seen_arr.count("rr"))
	$collectedcounter/HBoxContainer/Label19.text = str(GlobalData.seen_arr.count("ss"))
	$collectedcounter/HBoxContainer/Label20.text = str(GlobalData.seen_arr.count("tt"))
	$collectedcounter/HBoxContainer/Label21.text = str(GlobalData.seen_arr.count("uu"))
	$collectedcounter/HBoxContainer/Label22.text = str(GlobalData.seen_arr.count("vv"))
	$collectedcounter/HBoxContainer/Label23.text = str(GlobalData.seen_arr.count("ww"))
	$collectedcounter/HBoxContainer/Label24.text = str(GlobalData.seen_arr.count("xx"))
	$collectedcounter/HBoxContainer/Label25.text = str(GlobalData.seen_arr.count("yy"))
	$collectedcounter/HBoxContainer/Label26.text = str(GlobalData.seen_arr.count("zz"))


func _on_start_pressed() -> void:
	#add starting pack
	#print(main)
	GlobalData.packcount_box = main.STARTING_PACK
	GlobalData.packcount_box = 2
	#add starting money
	GlobalData.money_current = main.STARTING_MONEY
	#state = Standby
	GlobalStateController.current_state = GlobalStateController.GameState.STANDBY
	
