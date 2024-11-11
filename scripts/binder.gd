extends Node2D

signal  flip_finished

@onready var current_page: int = 1
@onready var page1:= $Page/Page1
@onready var page2:= $Page/Page2
@onready var page3:= $Page/Page3
@onready var page4:= $Page/Page4

@onready var left_btn:= $LeftPage
@onready var Right_btn:= $RightPage

func _process(_delta: float) -> void:
	#_update_collection()
	if current_page == 1:
		left_btn.disabled = true
		Right_btn.disabled = false
	elif current_page == 2:
		left_btn.disabled = false
		Right_btn.disabled = false
	elif current_page == 4:
		left_btn.disabled = false
		Right_btn.disabled = true
	#update price
	_update_price_sheet()


func _update_collection():
##a-z
	if GlobalData.collection_arr.has("aa"):
		$Page/Page1/Slot_aa.visible = true
	else:
		$Page/Page1/Slot_aa.visible = false
	
	if GlobalData.collection_arr.has("bb"):
		$Page/Page1/Slot_bb.visible = true
	else:
		$Page/Page1/Slot_bb.visible = false
	
	if GlobalData.collection_arr.has("cc"):
		$Page/Page1/Slot_cc.visible = true
	else:
		$Page/Page1/Slot_cc.visible = false
	
	if GlobalData.collection_arr.has("dd"):
		$Page/Page1/Slot_dd.visible = true
	else:
		$Page/Page1/Slot_dd.visible = false
	
	if GlobalData.collection_arr.has("ee"):
		$Page/Page1/Slot_ee.visible = true
	else:
		$Page/Page1/Slot_ee.visible = false
	
	if GlobalData.collection_arr.has("ff"):
		$Page/Page1/Slot_ff.visible = true
	else:
		$Page/Page1/Slot_ff.visible = false
	
	if GlobalData.collection_arr.has("gg"):
		$Page/Page1/Slot_gg.visible = true
	else:
		$Page/Page1/Slot_gg.visible = false
	
	if GlobalData.collection_arr.has("hh"):
		$Page/Page1/Slot_hh.visible = true
	else:
		$Page/Page1/Slot_hh.visible = false
	
	if GlobalData.collection_arr.has("ii"):
		$Page/Page1/Slot_ii.visible = true
	else:
		$Page/Page1/Slot_ii.visible = false
	
	if GlobalData.collection_arr.has("jj"):
		$Page/Page2/Slot_jj.visible = true
	else:
		$Page/Page2/Slot_jj.visible = false
	
	if GlobalData.collection_arr.has("kk"):
		$Page/Page2/Slot_kk.visible = true
	else:
		$Page/Page2/Slot_kk.visible = false
	
	if GlobalData.collection_arr.has("ll"):
		$Page/Page2/Slot_ll.visible = true
	else:
		$Page/Page2/Slot_ll.visible = false
	
	if GlobalData.collection_arr.has("mm"):
		$Page/Page2/Slot_mm.visible = true
	else:
		$Page/Page2/Slot_mm.visible = false
	
	if GlobalData.collection_arr.has("nn"):
		$Page/Page2/Slot_nn.visible = true
	else:
		$Page/Page2/Slot_nn.visible = false
	
	if GlobalData.collection_arr.has("oo"):
		$Page/Page2/Slot_oo.visible = true
	else:
		$Page/Page2/Slot_oo.visible = false
	
	if GlobalData.collection_arr.has("pp"):
		$Page/Page2/Slot_pp.visible = true
	else:
		$Page/Page2/Slot_pp.visible = false
	
	if GlobalData.collection_arr.has("qq"):
		$Page/Page2/Slot_qq.visible = true
	else:
		$Page/Page2/Slot_qq.visible = false
	
	if GlobalData.collection_arr.has("rr"):
		$Page/Page2/Slot_rr.visible = true
	else:
		$Page/Page2/Slot_rr.visible = false
	
	if GlobalData.collection_arr.has("ss"):
		$Page/Page3/Slot_ss.visible = true
	else:
		$Page/Page3/Slot_ss.visible = false
	
	if GlobalData.collection_arr.has("tt"):
		$Page/Page3/Slot_tt.visible = true
	else:
		$Page/Page3/Slot_tt.visible = false
	
	if GlobalData.collection_arr.has("uu"):
		$Page/Page3/Slot_uu.visible = true
	else:
		$Page/Page3/Slot_uu.visible = false
	
	if GlobalData.collection_arr.has("vv"):
		$Page/Page3/Slot_vv.visible = true
	else:
		$Page/Page3/Slot_vv.visible = false
	
	if GlobalData.collection_arr.has("ww"):
		$Page/Page3/Slot_ww.visible = true
	else:
		$Page/Page3/Slot_ww.visible = false
	
	if GlobalData.collection_arr.has("xx"):
		$Page/Page3/Slot_xx.visible = true
	else:
		$Page/Page3/Slot_xx.visible = false
	
	if GlobalData.collection_arr.has("yy"):
		$Page/Page3/Slot_yy.visible = true
	else:
		$Page/Page3/Slot_yy.visible = false
	
	if GlobalData.collection_arr.has("zz"):
		$Page/Page3/Slot_zz.visible = true
	else:
		$Page/Page3/Slot_zz.visible = false

##Extra
	if GlobalData.collection_arr.has("ex_promo"):
		$Page/Page3/Slot_ex_promo.visible = true
	else:
		$Page/Page3/Slot_ex_promo.visible = false
	
	if GlobalData.collection_arr.has("ex_misprint"):
		$Page/Page4/Slot_ex_misprint.visible = true
	else:
		$Page/Page4/Slot_ex_misprint.visible = false
	
	if GlobalData.collection_arr.has("ex_driver"):
		$Cover/Driver.rotation = randi_range(-5, 5) 
		$Cover/Driver.visible = true
	else:
		$Cover/Driver.visible = false
	
	if GlobalData.collection_arr.has("ex_credit"):
		$Cover/Credit.rotation = randi_range(-5, 5) 
		$Cover/Credit.visible = true
	else:
		$Cover/Credit.visible = false

func _flip_finished():
	flip_finished.emit()

func _on_left_page_pressed() -> void:
	if current_page == 2:
		left_btn.disabled = true
		$AnimationPlayer.play("backward1")
		await flip_finished
		left_btn.disabled = false
		
		current_page = 1
	
	elif current_page == 3:
		left_btn.disabled = true
		$AnimationPlayer.play("backward2")
		await flip_finished
		left_btn.disabled = false
		
		current_page = 2

func _on_right_page_pressed() -> void:
	if current_page == 1:
		Right_btn.disabled = true
		$AnimationPlayer.play("forward1")
		await flip_finished
		Right_btn.disabled = false
		
		current_page = 2
	
	elif current_page == 2:
		Right_btn.disabled = true
		$AnimationPlayer.play("forward2")
		await flip_finished
		Right_btn.disabled = false
		
		current_page = 3

func _update_price_sheet():
	$Cover/PriceSheet/Control/HBoxContainer/Price1/Label.text = "$"+str(GlobalData.price_dict["aa"])
	$Cover/PriceSheet/Control/HBoxContainer/Price1/Label2.text = "$"+str(GlobalData.price_dict["bb"])
	$Cover/PriceSheet/Control/HBoxContainer/Price1/Label3.text = "$"+str(GlobalData.price_dict["cc"])
	$Cover/PriceSheet/Control/HBoxContainer/Price1/Label4.text = "$"+str(GlobalData.price_dict["dd"])
	$Cover/PriceSheet/Control/HBoxContainer/Price1/Label5.text = "$"+str(GlobalData.price_dict["ee"])
	$Cover/PriceSheet/Control/HBoxContainer/Price1/Label6.text = "$"+str(GlobalData.price_dict["ff"])
	$Cover/PriceSheet/Control/HBoxContainer/Price1/Label7.text = "$"+str(GlobalData.price_dict["gg"])
	$Cover/PriceSheet/Control/HBoxContainer/Price1/Label8.text = "$"+str(GlobalData.price_dict["hh"])
	$Cover/PriceSheet/Control/HBoxContainer/Price1/Label9.text = "$"+str(GlobalData.price_dict["ii"])
	$Cover/PriceSheet/Control/HBoxContainer/Price1/Label10.text = "$"+str(GlobalData.price_dict["jj"])
	$Cover/PriceSheet/Control/HBoxContainer/Price1/Label11.text = "$"+str(GlobalData.price_dict["kk"])
	$Cover/PriceSheet/Control/HBoxContainer/Price1/Label12.text = "$"+str(GlobalData.price_dict["ll"])
	$Cover/PriceSheet/Control/HBoxContainer/Price1/Label13.text = "$"+str(GlobalData.price_dict["mm"])
	
	$Cover/PriceSheet/Control/HBoxContainer/Price2/Label.text = "$"+str(GlobalData.price_dict["nn"])
	$Cover/PriceSheet/Control/HBoxContainer/Price2/Label2.text = "$"+str(GlobalData.price_dict["oo"])
	$Cover/PriceSheet/Control/HBoxContainer/Price2/Label3.text = "$"+str(GlobalData.price_dict["pp"])
	$Cover/PriceSheet/Control/HBoxContainer/Price2/Label4.text = "$"+str(GlobalData.price_dict["qq"])
	$Cover/PriceSheet/Control/HBoxContainer/Price2/Label5.text = "$"+str(GlobalData.price_dict["rr"])
	$Cover/PriceSheet/Control/HBoxContainer/Price2/Label6.text = "$"+str(GlobalData.price_dict["ss"])
	$Cover/PriceSheet/Control/HBoxContainer/Price2/Label7.text = "$"+str(GlobalData.price_dict["tt"])
	$Cover/PriceSheet/Control/HBoxContainer/Price2/Label8.text = "$"+str(GlobalData.price_dict["uu"])
	$Cover/PriceSheet/Control/HBoxContainer/Price2/Label9.text = "$"+str(GlobalData.price_dict["vv"])
	$Cover/PriceSheet/Control/HBoxContainer/Price2/Label10.text = "$"+str(GlobalData.price_dict["ww"])
	$Cover/PriceSheet/Control/HBoxContainer/Price2/Label11.text = "$"+str(GlobalData.price_dict["xx"])
	$Cover/PriceSheet/Control/HBoxContainer/Price2/Label12.text = "$"+str(GlobalData.price_dict["yy"])
	$Cover/PriceSheet/Control/HBoxContainer/Price2/Label13.text = "$"+str(GlobalData.price_dict["zz"])
	$Cover/PriceSheet/Control/HBoxContainer/Price2/Label14.text = "$"+str(GlobalData.price_dict["ex_misprint"])

##DEBUG
func _on_test_2_pressed() -> void:
	GlobalData.collection_arr.append_array(GlobalData.completed_arr)

func _on_test_3_pressed() -> void:
	GlobalData.collection_arr.clear()

func _on_test_4_pressed() -> void:
	_update_collection()
