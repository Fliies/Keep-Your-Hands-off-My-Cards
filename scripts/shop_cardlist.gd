extends Control

class_name ShopCardlist

@export var card_censor: Texture2D
@export var card_soldout: Texture2D

@export var btm_lbl: Label

@onready var card_grid:= %CardlistGrid
@onready var cardlist_slot = card_grid.get_children()

func _ready() -> void:
	for node in cardlist_slot:
		node.connect("cannot_buy", _on_cannot_buy)
		node.connect("mouse_out_buy_btn", _on_mouse_out_btn)
		node.connect("mouse_in_sell", _on_can_sell)
		node.connect("mouse_out_sell_btn", _on_mouse_out_btn)

##SETUP 
func _update_slot_visual(codename:String, sprite_node:Sprite2D, censor_node:Sprite2D, _buy_btn:Button, _Sell_btn:Button, _amount_lbl:Label, _shop_amount_lbl:Label):
	##SETUP visual card 
	# sprite
	sprite_node.rotation_degrees = 0
	sprite_node.texture = load("res://Cards/CardSprite/%s.png" % codename)
	
	# avialable ( showing / censor / soldout )
	if GlobalData.shop_arr.has(codename):
		sprite_node.visible = true
		if GlobalData.seen_arr.has(codename): 
			censor_node.visible = false
		else: 
			censor_node.texture = card_censor
			censor_node.visible = true
	else: 
		sprite_node.visible = false
		
		censor_node.texture = card_soldout
		censor_node.visible = true

func _update_slot_btn(codename:String, _sprite_node:Sprite2D, _censor_node:Sprite2D, buy_btn:Button, Sell_btn:Button, amount_lbl:Label, _shop_amount_lbl:Label):
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
	_update_all_slot_visual()
	_update_all_slot_btn()

func _update_all_slot_visual():
	for codename in GlobalData.codename_arr:
		var index = GlobalData.codename_arr.find(codename)
		_update_slot_visual(codename, cardlist_slot[index].sprite, cardlist_slot[index].censor, cardlist_slot[index].buy_btn, cardlist_slot[index].sell_btn, cardlist_slot[index].amount_lbl, cardlist_slot[index].shop_amount_lbl)

func _update_all_slot_btn():
	for codename in GlobalData.codename_arr:
		var index = GlobalData.codename_arr.find(codename)
		_update_slot_btn(codename, cardlist_slot[index].sprite, cardlist_slot[index].censor, cardlist_slot[index].buy_btn, cardlist_slot[index].sell_btn, cardlist_slot[index].amount_lbl, cardlist_slot[index].shop_amount_lbl)


func _update_pricetag(codename:String, pricetag:Sprite2D, price_lbl:Label):
	#price lbl
	price_lbl.text = "$%.2f" % GlobalData.price_dict[codename]
	#sprite
	pricetag.rotation_degrees = 0
	pricetag.rotation_degrees = randi_range(-10,10)
	pricetag.position.x = randi_range(190,200)
func _update_all_pricetag():
	var index = 0
	for codename in GlobalData.codename_arr:
		_update_pricetag(codename, cardlist_slot[index].pricetag, cardlist_slot[index].price_lbl)
		index += 1


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
	#clear shop_arr
	GlobalData.shop_arr.clear()
	
	#append sell_card_arr
	GlobalData.shop_arr.append_array(GlobalData.card_sell_arr)
	GlobalData.card_sell_arr.clear()
	
	#new stock
	for codename in GlobalData.codename_arr:
		_random_available(codename)


##BUY n SELL BTN ACTION
#function
func _buy_card(codename:String):
	#handle card
	GlobalData.shop_arr.erase(codename)
	GlobalData.collection_arr.append(codename)
	
	#handle money
	GlobalData.money_current -= GlobalData.price_dict[codename]
	
	#handle buy n sell btn
	_update_all_slot_btn()
	#var index = GlobalData.codename_arr.find(codename)
	#_update_slot_btn(codename, cardlist_slot[index].sprite, cardlist_slot[index].censor, cardlist_slot[index].buy_btn, cardlist_slot[index].sell_btn, cardlist_slot[index].amount_lbl, cardlist_slot[index].shop_amount_lbl)
	
	#update visual
	var index = GlobalData.codename_arr.find(codename)
	_update_slot_visual(codename, cardlist_slot[index].sprite, cardlist_slot[index].censor, cardlist_slot[index].buy_btn, cardlist_slot[index].sell_btn, cardlist_slot[index].amount_lbl, cardlist_slot[index].shop_amount_lbl)
	
	
	#update seen_arr
	GlobalData.seen_arr.append(codename)
	
func _sell_card(codename:String):
	#handle card
	GlobalData.collection_arr.erase(codename)
	GlobalData.shop_arr.append(codename)
	
	#handle money
	GlobalData.money_current += GlobalData.price_dict[codename]
	
	#handle buy n sell btn
	_update_all_slot_btn()
	#var index = GlobalData.codename_arr.find(codename)
	#_update_slot_btn(codename, cardlist_slot[index].sprite, cardlist_slot[index].censor, cardlist_slot[index].buy_btn, cardlist_slot[index].sell_btn, cardlist_slot[index].amount_lbl, cardlist_slot[index].shop_amount_lbl)
	
	#update visual
	var index = GlobalData.codename_arr.find(codename)
	_update_slot_visual(codename, cardlist_slot[index].sprite, cardlist_slot[index].censor, cardlist_slot[index].buy_btn, cardlist_slot[index].sell_btn, cardlist_slot[index].amount_lbl, cardlist_slot[index].shop_amount_lbl)
	

#BTN in slot
func _on_cardlist_slot_buy(node: Variant) -> void:
	var index = cardlist_slot.find(node)
	_buy_card(GlobalData.codename_arr[index])
func _on_cardlist_slot_sell(node: Variant) -> void:
	var index = cardlist_slot.find(node)
	_sell_card(GlobalData.codename_arr[index])

#mouse in buy_btn
func _on_cannot_buy(node: Variant) -> void:
	var index = cardlist_slot.find(node)
	if GlobalData.shop_arr.has(GlobalData.codename_arr[index]):
		btm_lbl.label_settings.font_color = Color.ORANGE_RED
		btm_lbl.text = "not enough money"
	else:
		btm_lbl.label_settings.font_color = Color.ORANGE
		btm_lbl.text = "out of stock"

#mouse in sell
func _on_can_sell(node: Variant):
	var index = cardlist_slot.find(node)
	if GlobalData.collection_arr.has(GlobalData.codename_arr[index]):
		btm_lbl.label_settings.font_color = Color.SEA_GREEN
		btm_lbl.text = "sell a card for $%.2f" % GlobalData.price_dict[GlobalData.codename_arr[index]]
	else:
		btm_lbl.label_settings.font_color = Color.BLACK
		btm_lbl.text = "C l i c k   a   c a r d   t o   b u y"

#idle 
func _on_mouse_out_btn() -> void:
	btm_lbl.label_settings.font_color = Color.BLACK
	btm_lbl.text = "C l i c k   a   c a r d   t o   b u y"

##update all visual and btn
func _on_shop_cardlist_btn_pressed() -> void:
	_update_all_slot_visual_n_btn()
