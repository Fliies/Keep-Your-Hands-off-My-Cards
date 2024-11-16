extends Control

@onready var main:= get_parent().get_parent()

func _on_addpackto_box_pressed() -> void:
	GlobalData.packcount_box += 1
func _on_addpackto_single_pressed() -> void:
	GlobalData.packcount_single += 1
func _on_test_pressed() -> void:
	print(GlobalData.shop_arr)

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
	$collectedcounter/HBoxContainer/Label27.text = str(GlobalData.seen_arr.count("ex_misprint"))


func _on_start_pressed() -> void:
	#add starting pack
	GlobalData.packcount_box = GlobalData.STARTING_packs
	#GlobalData.packcount_box = 5
	#add starting money
	GlobalData.money_current = GlobalData.STARTING_money
	#state = Standby
	GlobalStateController.current_state = GlobalStateController.GameState.STANDBY
	


func _on_shop_pressed() -> void:
	GlobalStateController.current_state = GlobalStateController.GameState.SHOP_MENU
	main.shop.visible = true
	
	main.shop_btn.visible = false
	main.home_btn.visible = true


func _on_home_pressed() -> void:
	GlobalStateController.current_state = GlobalStateController.GameState.STANDBY
	main.shop.visible = false
	
	main.shop_btn.visible = true
	main.home_btn.visible = false


func _on_add_money_pressed() -> void:
	GlobalData.money_current += 20
