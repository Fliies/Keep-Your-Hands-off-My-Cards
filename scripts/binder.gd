extends Node2D

signal  flip_finished

@export_category("COMPLETED")
@export var completed_node:Sprite2D
@export var completed_04: Texture2D
@export var completed_14: Texture2D
@export var completed_24: Texture2D
@export var completed_34: Texture2D
@export var completed_44: Texture2D

@onready var current_page: int = 1
@onready var page1:= $Page/Page1
@onready var page2:= $Page/Page2
@onready var page3:= $Page/Page3
@onready var page4:= $Page/Page4

@onready var left_btn:= $LeftPage
@onready var right_btn:= $RightPage

@onready var animation_player:= $AnimationPlayer
@onready var timer:= $Timer

@export_category("NODE")
@export var sprite_node: Array[Sprite2D] 
@export var amount_node: Array[Sprite2D]
@export var amount_lbl: Array[Label]

@onready var inspect:= $InspectBG
@onready var inspect_sprite:= $InspectBG/InspectSprite
@onready var inspect_btn:= $InspectBtn
@onready var inspect_btn_arr: Array[Button]

func _ready() -> void:
	#completed
	completed_node.visible = false
	
	current_page = 1
	
	inspect.visible = false
	inspect.disabled = true
	
	inspect_btn_arr.append_array(inspect_btn.get_children())
	
	#slot visual
	_update_all_slot_visual()
	#inspect btn
	_update_inspect_btn_whole_page(current_page)

func _process(_delta: float) -> void:
	if GlobalStateController.current_state == GameStateController.GameState.BINDER:
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
		#_update_price_sheet()

##completed
func _first_completed(amount:int):
	##slot visual
	_update_all_slot_visual()
	_update_inspect_btn_whole_page(5)
	##to page 4
	current_page = 4
	page1.visible = false
	page2.visible = false
	page3.visible = false
	page4.visible = true
	
	GlobalData.completed = true
	if amount == 26:
		completed_node.texture = completed_04
	elif amount == 27:
		completed_node.texture = completed_14
	elif amount == 28:
		completed_node.texture = completed_24
	elif amount == 29:
		completed_node.texture = completed_34
	elif amount == 30:
		completed_node.texture = completed_44
	
	timer.start(1)
	await timer.timeout
	
	##animation
	animation_player.play("backward2")
	await flip_finished
	
	current_page = 23
	
	timer.start(1)
	await timer.timeout
	
	animation_player.play("backward1")
	await flip_finished
	
	current_page = 1
	
	##inspect btn
	
	timer.start(1)
	await timer.timeout
	
	
	animation_player.play("completed")
	await flip_finished
	
	##lower z index
	completed_node.z_index = 0
	
	GlobalStateController.current_state = GameStateController.GameState.BINDER
	_update_inspect_btn_whole_page(current_page)

func _update_completed(amount):
	match amount:
		26:
			completed_node.texture = completed_04
		27:
			completed_node.texture = completed_14
		28:
			completed_node.texture = completed_24
		29:
			completed_node.texture = completed_34
		30:
			completed_node.texture = completed_44


##signal
func _flip_finished():
	flip_finished.emit()

##slot Visual
func _update_slot_visual(codename:String,index:int):
	#visibility
	if GlobalData.collection_arr.has(codename):
		sprite_node[index].visible = true
	else:
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

func _update_all_slot_visual():
	_update_slot_visual("aa",0)
	_update_slot_visual("bb",1)
	_update_slot_visual("cc",2)
	_update_slot_visual("dd",3)
	_update_slot_visual("ee",4)
	_update_slot_visual("ff",5)
	_update_slot_visual("gg",6)
	_update_slot_visual("hh",7)
	_update_slot_visual("ii",8)
	_update_slot_visual("jj",9)
	_update_slot_visual("kk",10)
	_update_slot_visual("ll",11)
	_update_slot_visual("mm",12)
	_update_slot_visual("nn",13)
	_update_slot_visual("oo",14)
	_update_slot_visual("pp",15)
	_update_slot_visual("qq",16)
	_update_slot_visual("rr",17)
	_update_slot_visual("ss",18)
	_update_slot_visual("tt",19)
	_update_slot_visual("uu",20)
	_update_slot_visual("vv",21)
	_update_slot_visual("ww",22)
	_update_slot_visual("xx",23)
	_update_slot_visual("yy",24)
	_update_slot_visual("zz",25)
	_update_slot_visual("ex_promo",26)
	_update_slot_visual("ex_misprint",27)
	
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
	#_update_inspect_btn()
	#_checking_inspect_btn_whole_page(current_page)

##Change page btn
func _on_left_page_pressed() -> void:
	if current_page == 23:
		left_btn.disabled = true
		animation_player.play("backward1")
		await flip_finished
		left_btn.disabled = false
		
		current_page = 1
	
	elif current_page == 4:
		left_btn.disabled = true
		animation_player.play("backward2")
		await flip_finished
		left_btn.disabled = false
		
		current_page = 23
	
	##update inspect
	_update_inspect_btn_whole_page(current_page)

func _on_right_page_pressed() -> void:
	if current_page == 1:
		right_btn.disabled = true
		animation_player.play("forward1")
		await flip_finished
		right_btn.disabled = false
		
		current_page = 23
	
	elif current_page == 23:
		right_btn.disabled = true
		animation_player.play("forward2")
		await flip_finished
		right_btn.disabled = false
		
		current_page = 4
	
	###update inspect
	_update_inspect_btn_whole_page(current_page)

##back Cover
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

###OPEN / CLOSE binder
#func _on_binder_btn_pressed() -> void:
	#_update_all_slot()

##inspect
#func _update_inspect_btn():
	###page 1
	#if current_page == 1:
		#_checking_inspect_btn_whole_page(1)
		###disable left
		##_disable_left_inspect_btn()
		###check right
		##_checking_inspect_right()
	###page 23
	#elif current_page == 23:
		#_checking_inspect_btn_whole_page(23)
		###check left
		##_checking_inspect_left()
		###check right
		##_checking_inspect_right()
	###page 4
	#elif current_page == 4:
		#_checking_inspect_btn_whole_page(4)
		###disable right
		##_disable_right_inspect_btn()
		###check left
		##_checking_inspect_left()

##inspect CARD
func _disable_btn(btn:Button):
	btn.visible = false
	btn.disabled = true
func _enable_btn(btn:Button):
	btn.visible = true
	btn.disabled = false

#func _disable_left_inspect_btn():
	#var index = 0
	#while index < 9:
		#_disable_btn(inspect_btn_arr[index])
		#
		#index += 1
#func _disable_right_inspect_btn():
	#var index = 9
	#while index < 18:
		#_disable_btn(inspect_btn_arr[index])
		#
		#index += 1
#func _checking_inspect_left():
	#var index = 0
	#while index < 9:
		#if GlobalData.collection_arr.has(GlobalData.codename_arr[index]):
			#_enable_btn(inspect_btn_arr[index])
		#else:
			#_disable_btn(inspect_btn_arr[index])
		#
		#index += 1
#func _checking_inspect_right():
	#var index = 9
	#while index < 18:
		#if GlobalData.collection_arr.has(GlobalData.codename_arr[index]):
			#_enable_btn(inspect_btn_arr[index])
		#else:
			#_disable_btn(inspect_btn_arr[index])
		#
		#index += 1

func _checking_inspect_btn_from_collection(codename:String, btn_index:int):
	if GlobalData.collection_arr.has(codename):
		_enable_btn(inspect_btn_arr[btn_index])
	else:
		_disable_btn(inspect_btn_arr[btn_index])

func _update_inspect_btn_whole_page(page:int):
	match page:
		1:
			_disable_btn(inspect_btn_arr[0])
			_disable_btn(inspect_btn_arr[1])
			_disable_btn(inspect_btn_arr[2])
			_disable_btn(inspect_btn_arr[3])
			_disable_btn(inspect_btn_arr[4])
			_disable_btn(inspect_btn_arr[5])
			_disable_btn(inspect_btn_arr[6])
			_disable_btn(inspect_btn_arr[7])
			_disable_btn(inspect_btn_arr[8])
			
			_checking_inspect_btn_from_collection("aa",9)
			_checking_inspect_btn_from_collection("bb",10)
			_checking_inspect_btn_from_collection("cc",11)
			_checking_inspect_btn_from_collection("dd",12)
			_checking_inspect_btn_from_collection("ee",13)
			_checking_inspect_btn_from_collection("ff",14)
			_checking_inspect_btn_from_collection("gg",15)
			_checking_inspect_btn_from_collection("hh",16)
			_checking_inspect_btn_from_collection("ii",17)
		23:
			_checking_inspect_btn_from_collection("jj",0)
			_checking_inspect_btn_from_collection("kk",1)
			_checking_inspect_btn_from_collection("ll",2)
			_checking_inspect_btn_from_collection("mm",3)
			_checking_inspect_btn_from_collection("nn",4)
			_checking_inspect_btn_from_collection("oo",5)
			_checking_inspect_btn_from_collection("pp",6)
			_checking_inspect_btn_from_collection("qq",7)
			_checking_inspect_btn_from_collection("rr",8)
			_checking_inspect_btn_from_collection("ss",9)
			_checking_inspect_btn_from_collection("tt",10)
			_checking_inspect_btn_from_collection("uu",11)
			_checking_inspect_btn_from_collection("vv",12)
			_checking_inspect_btn_from_collection("ww",13)
			_checking_inspect_btn_from_collection("xx",14)
			_checking_inspect_btn_from_collection("yy",15)
			_checking_inspect_btn_from_collection("zz",16)
			_checking_inspect_btn_from_collection("ex_promo",17)
		4:
			_checking_inspect_btn_from_collection("ex_misprint",0)
			_disable_btn(inspect_btn_arr[1])
			_disable_btn(inspect_btn_arr[2])
			_disable_btn(inspect_btn_arr[3])
			_disable_btn(inspect_btn_arr[4])
			_disable_btn(inspect_btn_arr[5])
			_disable_btn(inspect_btn_arr[6])
			_disable_btn(inspect_btn_arr[7])
			_disable_btn(inspect_btn_arr[8])
			
			_disable_btn(inspect_btn_arr[9])
			_disable_btn(inspect_btn_arr[10])
			_disable_btn(inspect_btn_arr[11])
			_disable_btn(inspect_btn_arr[12])
			_disable_btn(inspect_btn_arr[13])
			_disable_btn(inspect_btn_arr[14])
			_disable_btn(inspect_btn_arr[15])
			_disable_btn(inspect_btn_arr[16])
			_disable_btn(inspect_btn_arr[17])
		5:
			_disable_btn(inspect_btn_arr[0])
			_disable_btn(inspect_btn_arr[1])
			_disable_btn(inspect_btn_arr[2])
			_disable_btn(inspect_btn_arr[3])
			_disable_btn(inspect_btn_arr[4])
			_disable_btn(inspect_btn_arr[5])
			_disable_btn(inspect_btn_arr[6])
			_disable_btn(inspect_btn_arr[7])
			_disable_btn(inspect_btn_arr[8])
			
			_disable_btn(inspect_btn_arr[9])
			_disable_btn(inspect_btn_arr[10])
			_disable_btn(inspect_btn_arr[11])
			_disable_btn(inspect_btn_arr[12])
			_disable_btn(inspect_btn_arr[13])
			_disable_btn(inspect_btn_arr[14])
			_disable_btn(inspect_btn_arr[15])
			_disable_btn(inspect_btn_arr[16])
			_disable_btn(inspect_btn_arr[17])

#close inspector
func _on_inspect_bg_pressed() -> void:
	inspect.visible = false
	inspect.disabled = true
#open inspector
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
	_update_all_slot_visual()
	_update_inspect_btn_whole_page(current_page)
