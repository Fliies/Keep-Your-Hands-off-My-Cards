extends Node2D

signal  flip_finished

@onready var current_page: int = 1
@onready var page1:= $Page/Page1
@onready var page2:= $Page/Page2
@onready var page3:= $Page/Page3
@onready var page4:= $Page/Page4

@onready var left_btn:= $LeftPage
@onready var right_btn:= $RightPage

@export var sprite_node: Array[Sprite2D] 
@export var amount_node: Array[Sprite2D]
@export var amount_lbl: Array[Label]

@onready var inspect:= $InspectBG
@onready var inspect_sprite:= $InspectBG/InspectSprite
@onready var inspect_btn:= $InspectBtn
@onready var inspect_btn_arr: Array[Button]

func _ready() -> void:
	inspect.visible = false
	inspect.disabled = true
	
	inspect_btn_arr.append_array(inspect_btn.get_children())
	_disable_left_inspect_btn()
	_disable_right_inspect_btn()

func _process(_delta: float) -> void:
	if current_page == 1:
		left_btn.visible = false
		left_btn.disabled = true
		
		right_btn.visible = true
		right_btn.disabled = false
	elif current_page == 23:
		left_btn.visible = true
		left_btn.disabled = false
		
		right_btn.visible = true
		right_btn.disabled = false
	elif current_page == 4:
		left_btn.visible = true
		left_btn.disabled = false
		
		right_btn.visible = false
		right_btn.disabled = true
	#update price
	_update_price_sheet()

func _update_slot(codename:String,index:int):
	#visibility
	if GlobalData.collection_arr.has(codename):
		sprite_node[index].visible = true
		#$Page/Page1/Slot_aa.visible = true
	else:
		#$Page/Page1/Slot_aa.visible = false
		sprite_node[index].visible = false
	
	#amount
	if GlobalData.collection_arr.count(codename) >= 2:
		#show amount
		amount_node[index].visible = true
		#update amount
		amount_lbl[index].text = str(GlobalData.collection_arr.count(codename))
	else:
		#hide amount
		amount_node[index].visible = false

func _update_all_slot():
	var index = 0
	for codename in GlobalData.codename_arr:
		_update_slot(codename, index)
		
		index += 1
	
	_update_slot("ex_promo",26)
	_update_slot("ex_misprint",27)
	
	if GlobalData.collection_arr.has("ex_driver"):
		sprite_node[28].rotation = randi_range(-5, 5) 
		sprite_node[28].visible = true
	else:
		sprite_node[28].visible = false
	
	if GlobalData.collection_arr.has("ex_credit"):
		sprite_node[29].rotation = randi_range(-5, 5) 
		sprite_node[29].visible = true
	else:
		sprite_node[29].visible = false
	
	##update inspect
	_update_inspect_btn()

func _flip_finished():
	flip_finished.emit()

func _on_left_page_pressed() -> void:
	if current_page == 23:
		left_btn.disabled = true
		$AnimationPlayer.play("backward1")
		await flip_finished
		left_btn.disabled = false
		
		current_page = 1
	
	elif current_page == 4:
		left_btn.disabled = true
		$AnimationPlayer.play("backward2")
		await flip_finished
		left_btn.disabled = false
		
		current_page = 23
	
	##update inspect
	_update_inspect_btn()

func _on_right_page_pressed() -> void:
	if current_page == 1:
		right_btn.disabled = true
		$AnimationPlayer.play("forward1")
		await flip_finished
		right_btn.disabled = false
		
		current_page = 23
	
	elif current_page == 23:
		right_btn.disabled = true
		$AnimationPlayer.play("forward2")
		await flip_finished
		right_btn.disabled = false
		
		current_page = 4
	
	##update inspect
	_update_inspect_btn()

func _update_price_sheet():
	$Cover/PriceSheet/Control/HBoxContainer/Price1/Label.text = "$%.2f" % GlobalData.price_dict["aa"]
	$Cover/PriceSheet/Control/HBoxContainer/Price1/Label2.text = "$%.2f" % GlobalData.price_dict["bb"]
	$Cover/PriceSheet/Control/HBoxContainer/Price1/Label3.text = "$%.2f" % GlobalData.price_dict["cc"]
	$Cover/PriceSheet/Control/HBoxContainer/Price1/Label4.text = "$%.2f" % GlobalData.price_dict["dd"]
	$Cover/PriceSheet/Control/HBoxContainer/Price1/Label5.text = "$%.2f" % GlobalData.price_dict["ee"]
	$Cover/PriceSheet/Control/HBoxContainer/Price1/Label6.text = "$%.2f" % GlobalData.price_dict["ff"]
	$Cover/PriceSheet/Control/HBoxContainer/Price1/Label7.text = "$%.2f" % GlobalData.price_dict["gg"]
	$Cover/PriceSheet/Control/HBoxContainer/Price1/Label8.text = "$%.2f" % GlobalData.price_dict["hh"]
	$Cover/PriceSheet/Control/HBoxContainer/Price1/Label9.text = "$%.2f" % GlobalData.price_dict["ii"]
	$Cover/PriceSheet/Control/HBoxContainer/Price1/Label10.text = "$%.2f" % GlobalData.price_dict["jj"]
	$Cover/PriceSheet/Control/HBoxContainer/Price1/Label11.text = "$%.2f" % GlobalData.price_dict["kk"]
	$Cover/PriceSheet/Control/HBoxContainer/Price1/Label12.text = "$%.2f" % GlobalData.price_dict["ll"]
	$Cover/PriceSheet/Control/HBoxContainer/Price1/Label13.text = "$%.2f" % GlobalData.price_dict["mm"]
	
	$Cover/PriceSheet/Control/HBoxContainer/Price2/Label.text = "$%.2f" % GlobalData.price_dict["nn"]
	$Cover/PriceSheet/Control/HBoxContainer/Price2/Label2.text = "$%.2f" % GlobalData.price_dict["oo"]
	$Cover/PriceSheet/Control/HBoxContainer/Price2/Label3.text = "$%.2f" % GlobalData.price_dict["pp"]
	$Cover/PriceSheet/Control/HBoxContainer/Price2/Label4.text = "$%.2f" % GlobalData.price_dict["qq"]
	$Cover/PriceSheet/Control/HBoxContainer/Price2/Label5.text = "$%.2f" % GlobalData.price_dict["rr"]
	$Cover/PriceSheet/Control/HBoxContainer/Price2/Label6.text = "$%.2f" % GlobalData.price_dict["ss"]
	$Cover/PriceSheet/Control/HBoxContainer/Price2/Label7.text = "$%.2f" % GlobalData.price_dict["tt"]
	$Cover/PriceSheet/Control/HBoxContainer/Price2/Label8.text = "$%.2f" % GlobalData.price_dict["uu"]
	$Cover/PriceSheet/Control/HBoxContainer/Price2/Label9.text = "$%.2f" % GlobalData.price_dict["vv"]
	$Cover/PriceSheet/Control/HBoxContainer/Price2/Label10.text = "$%.2f" % GlobalData.price_dict["ww"]
	$Cover/PriceSheet/Control/HBoxContainer/Price2/Label11.text = "$%.2f" % GlobalData.price_dict["xx"]
	$Cover/PriceSheet/Control/HBoxContainer/Price2/Label12.text = "$%.2f" % GlobalData.price_dict["yy"]
	$Cover/PriceSheet/Control/HBoxContainer/Price2/Label13.text = "$%.2f" % GlobalData.price_dict["zz"]
	$Cover/PriceSheet/Control/HBoxContainer/Price2/Label14.text = "$%.2f" % GlobalData.price_dict["ex_misprint"]

##inspect
func _update_inspect_btn():
	pass
	##page 1
	if current_page == 1:
		#disable left
		_disable_left_inspect_btn()
		#check right
		_checking_inspect_right()
	##page 23
	elif current_page == 23:
		#check left
		_checking_inspect_left()
		#check right
		_checking_inspect_right()
	##page 4
	elif current_page == 4:
		#disable right
		_disable_right_inspect_btn()
		#check left
		_checking_inspect_left()

func _disable_btn(btn:Button):
	btn.visible = false
	btn.disabled = true
func _enable_btn(btn:Button):
	btn.visible = true
	btn.disabled = false

func _disable_left_inspect_btn():
	var index = 0
	while index < 9:
		_disable_btn(inspect_btn_arr[index])
		
		index += 1
func _disable_right_inspect_btn():
	var index = 9
	while index < 18:
		_disable_btn(inspect_btn_arr[index])
		
		index += 1

func _checking_inspect_left():
	var index = 0
	while index < 9:
		if GlobalData.collection_arr.has(GlobalData.codename_arr[index]):
			_enable_btn(inspect_btn_arr[index])
		else:
			_disable_btn(inspect_btn_arr[index])
		
		index += 1
func _checking_inspect_right():
	var index = 9
	while index < 18:
		if GlobalData.collection_arr.has(GlobalData.codename_arr[index]):
			_enable_btn(inspect_btn_arr[index])
		else:
			_disable_btn(inspect_btn_arr[index])
		
		index += 1

##reset inspector
func _on_inspect_bg_pressed() -> void:
	inspect.visible = false
	inspect.disabled = true

func _show_inspect_card(codename:String):
	inspect_sprite.texture = load("res://Cards/CardSprite/%s.png" % codename)
	
	inspect.visible = true
	inspect.disabled = false


func _on_left_1_pressed() -> void:
	if current_page == 23:
		_show_inspect_card("jj")
	elif current_page == 4:
		_show_inspect_card("ex_misprint")
func _on_left_2_pressed() -> void:
	if current_page == 23:
		_show_inspect_card("kk")
func _on_left_3_pressed() -> void:
	if current_page == 23:
		_show_inspect_card("ll")
func _on_left_4_pressed() -> void:
	if current_page == 23:
		_show_inspect_card("mm")
func _on_left_5_pressed() -> void:
	if current_page == 23:
		_show_inspect_card("nn")
func _on_left_6_pressed() -> void:
	if current_page == 23:
		_show_inspect_card("oo")
func _on_left_7_pressed() -> void:
	if current_page == 23:
		_show_inspect_card("pp")
func _on_left_8_pressed() -> void:
	if current_page == 23:
		_show_inspect_card("qq")
func _on_left_9_pressed() -> void:
	if current_page == 23:
		_show_inspect_card("rr")

func _on_right_1_pressed() -> void:
	if current_page == 1:
		_show_inspect_card("aa")
	elif current_page == 23:
		_show_inspect_card("ss")
func _on_right_2_pressed() -> void:
	if current_page == 1:
		_show_inspect_card("bb")
	elif current_page == 23:
		_show_inspect_card("tt")
func _on_right_3_pressed() -> void:
	if current_page == 1:
		_show_inspect_card("cc")
	elif current_page == 23:
		_show_inspect_card("uu")
func _on_right_4_pressed() -> void:
	if current_page == 1:
		_show_inspect_card("dd")
	elif current_page == 23:
		_show_inspect_card("vv")
func _on_right_5_pressed() -> void:
	if current_page == 1:
		_show_inspect_card("ee")
	elif current_page == 23:
		_show_inspect_card("ww")
func _on_right_6_pressed() -> void:
	if current_page == 1:
		_show_inspect_card("ff")
	elif current_page == 23:
		_show_inspect_card("xx")
func _on_right_7_pressed() -> void:
	if current_page == 1:
		_show_inspect_card("gg")
	elif current_page == 23:
		_show_inspect_card("yy")
func _on_right_8_pressed() -> void:
	if current_page == 1:
		_show_inspect_card("hh")
	elif current_page == 23:
		_show_inspect_card("zz")
func _on_right_9_pressed() -> void:
	if current_page == 1:
		_show_inspect_card("ii")
	elif current_page == 23:
		_show_inspect_card("ex_promo")



##DEBUG
func _on_test_2_pressed() -> void:
	GlobalData.collection_arr.append_array(GlobalData.completed_arr)

func _on_test_3_pressed() -> void:
	GlobalData.collection_arr.clear()

func _on_test_4_pressed() -> void:
	_update_all_slot()
