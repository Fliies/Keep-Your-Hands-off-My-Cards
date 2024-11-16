extends Control

@onready var card_censor:= load("res://Cards/CardSprite/card-censor.png")
@onready var card_soldout:= load("res://Cards/CardSprite/card-soudout.png")

#func _ready() -> void:
###ENTER the SHOP
## update PRICE_DICT
	#GlobalData._update_price()
## SETUP STOCK CARDLIST
	#_initial_stock_cardlist() #temp
## price + tag
	#_update_all_pricetag()
	##SETUP visual card 
		## sprite
		## avialable
		## soldout
		## censor
	##update buy n sell btn
	##update amount
	#_update_all_slot_visual_n_btn()

##ENTER TRADING / BUY or SELL btn
# _update_slot_visual_n_btn
	#SETUP visual card 
		# sprite
		# avialable
		# soldout
		# censor
	#update buy n sell btn
	#update amount

@onready var card_grid:= %CardlistGrid
@onready var cardlist_slot = card_grid.get_children()
#@onready var codename_arr:= ["aa", "bb", "cc", "dd", "ee", "ff", "gg", "hh", "ii" ,"jj", "kk", "ll", "mm", "nn", "oo", "pp", "qq", "rr", "ss", "tt", "uu", "vv", "ww", "xx", "yy", "zz",]


func _on_shop_cardlist_btn_pressed() -> void:
	_update_all_slot_visual_n_btn()

##SETUP 
func _update_slot_visual_n_btn(codename:String, sprite_node:Sprite2D, censor_node:Sprite2D, buy_btn:Button, Sell_btn:Button, amount_lbl:Label):
	##SETUP visual card 
	# sprite
	sprite_node.texture = load("res://Cards/CardSprite/%s.png" % codename)
	
	# avialable ( showing / censor / soldout )
	if GlobalData.shop_arr.has(codename):
		if GlobalData.collection_arr.has(codename): 
			censor_node.visible = false
		else: 
			censor_node.texture = card_censor
			censor_node.visible = true
	else: 
		censor_node.texture = card_soldout
		censor_node.visible = true
	
	##update BUY n SELL btn
	#BUY_btn from money and shop_arr
	if GlobalData.shop_arr.has(codename):
		if GlobalData.money_current >= GlobalData.price_dict[codename]:
			#can buy
			buy_btn.disabled = false
		else:
			#cannot buy
			buy_btn.disabled = true
	else:
		#out of stock
		buy_btn.disabled = true
	
	#SELL_btn from collection
	if GlobalData.collection_arr.has(codename):
		#can Sell
		Sell_btn.disabled = false
	else:
		#cannot Sell
		Sell_btn.disabled = true
	
	##update having amount
	amount_lbl.text = str(GlobalData.collection_arr.count(codename))
func _update_all_slot_visual_n_btn():
	var index = 0
	for codename in GlobalData.codename_arr:
		_update_slot_visual_n_btn(codename, cardlist_slot[index].sprite, cardlist_slot[index].censor, cardlist_slot[index].buy_btn, cardlist_slot[index].sell_btn, cardlist_slot[index].amount_lbl)
		index += 1

func _update_pricetag(codename:String, pricetag:Sprite2D, price_lbl:Label):
	#price lbl
	price_lbl.text = "$%.2f" % GlobalData.price_dict[codename]
	#sprite
	pricetag.rotation_degrees = randi_range(-10,20)
	pricetag.position.x = randi_range(50,90)
func _update_all_pricetag():
	var index = 0
	for codename in GlobalData.codename_arr:
		_update_pricetag(codename, cardlist_slot[index].pricetag, cardlist_slot[index].price_lbl)
		index += 1


##BUY n SELL BTN ACTION
func _buy_card(codename:String):
	GlobalData.shop_arr.erase(codename)
	GlobalData.collection_arr.append(codename)
	
	_update_all_slot_visual_n_btn()
func _Sell_card(codename:String):
	GlobalData.collection_arr.erase(codename)
	GlobalData.shop_arr.append(codename)
	
	_update_all_slot_visual_n_btn()


##available?
func _random_available(codename:String):
	# cu 90%
	if GlobalData.common_arr.has(codename) or GlobalData.uncommon_arr.has(codename):
		var rng = randi_range(1,10)
		if rng == 1:
			#out of stock
			pass
		else:
			#add to shop_arr
			GlobalData.shop_arr.append(codename)
	# rare 75%
	elif GlobalData.rare_arr.has(codename):
		var rng = randi_range(1,4)
		if rng == 1:
			#out of stock
			pass
		else:
			GlobalData.shop_arr.append(codename)
	# secret 100%
	elif GlobalData.secret_arr.has(codename):
		GlobalData.shop_arr.append(codename)
func _initial_stock_cardlist():
	for codename in GlobalData.codename_arr:
		_random_available(codename)
