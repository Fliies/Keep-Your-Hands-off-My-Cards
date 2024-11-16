extends Control

class_name Shop

@export var promo: bool = true

@export_category("SCENE")
@export var shop: Control
@export var shop_menu: Control
@export var shop_cardlist: Control
@export var shop_offer: Control
@export var text_dyn: VBoxContainer

@export_category("Label")
@export var shop_cardlist_lbl_hover: Label
@export var shop_cardlist_lbl_idle: Label
@export var shop_offer_lbl: Label

@export var text_idle: Label

@export var text_dyn_up: Label
@export var text_dyn_low: Label

@export_category("BUTTON")
@export var shop_offer_btn: Button
@export var shop_trade_btn: Button
@export var btn_buy_1_pack: Button
@export var btn_buy_5_packs: Button
@export var btn_buy_box: Button

func _ready() -> void:
	#self.visible = false 
	
	shop_menu.visible = true
	
	shop_cardlist.visible = false
	shop_offer.visible = false
	
	shop_cardlist_lbl_hover.visible = false
	shop_cardlist_lbl_idle.visible = true
	
	text_idle.visible = true
	text_dyn.visible = false


##SHOP MENU
#offer
func _on_offer_btn_pressed() -> void:
	shop_menu.visible = false
	shop_offer.visible = true
#cardList
func _on_shop_cardlist_btn_pressed() -> void:
	#visiblility
	shop_menu.visible = false
	shop_cardlist.visible = true


##back BTN to Shop Menu
#offer
func _on_offer_back_btn_pressed() -> void: 
	#visiblility
	shop_menu.visible = true
	shop_offer.visible = false
#cardlist
func _on_card_list_back_btn_pressed() -> void: 
	#visiblility
	shop_menu.visible = true
	shop_cardlist.visible = false


##text when mouse in BTN
#offer
func _on_offer_btn_mouse_entered() -> void:
	text_idle.visible = false
	text_dyn.visible = true
	
	text_dyn_up.text = "SPECIAL DEAL!"
	text_dyn_low.text = "ONE TIME OFFER!"

#buy cardlist
func _on_shop_cardlist_btn_mouse_entered() -> void:
	text_idle.visible = false
	text_dyn.visible = true
	
	var yap = [
		"let's see what's in stock!",
		"looking for a card?",
		"wanna trade?",
		"need some money?",
		"'SECRET' is very hard to find, isn't it ;)",
		"sell some 'Rare' will ya",
		"let see what you got!",
		"I <3 MOO DENG"
	]
	
	text_dyn_up.text = "BUY / SELL CARDS"
	text_dyn_low.text = yap.pick_random()
	
	shop_cardlist_lbl_hover.visible = true
	shop_cardlist_lbl_idle.visible = false

#pack
func _on_buy_1_pack_mouse_entered() -> void:
	text_idle.visible = false
	text_dyn.visible = true
	
	text_dyn_up.text = "BUY 1 PACK"
	text_dyn_low.text = "for $10"
func _on_buy_5_packs_mouse_entered() -> void:
	text_idle.visible = false
	text_dyn.visible = true
	
	text_dyn_up.text = "BUY 5 PACKS"
	text_dyn_low.text = "for $50"

#box
func _on_buy_box_mouse_entered() -> void:
	text_idle.visible = false
	text_dyn.visible = true
	
	text_dyn_up.text = "BUY 1 BOX"
	text_dyn_low.text = "10 + 2 packs for only $90!"

##text when mouse OUT BTN
func _mouse_out():
	text_idle.visible = true
	text_dyn.visible = false
func _on_offer_btn_mouse_exited() -> void:
	_mouse_out()
func _on_shop_cardlist_btn_mouse_exited() -> void:
	shop_cardlist_lbl_hover.visible = false
	shop_cardlist_lbl_idle.visible = true
	_mouse_out()
func _on_buy_1_pack_mouse_exited() -> void:
	_mouse_out()
func _on_buy_5_packs_mouse_exited() -> void:
	_mouse_out()
func _on_buy_box_mouse_exited() -> void:
	_mouse_out()

func _on_shop_btn_pressed() -> void:
	##ENTER the SHOP
# update PRICE_DICT
	GlobalData._update_price()
# SETUP STOCK CARDLIST
	shop_cardlist._initial_stock_cardlist() #temp
# price + tag
	shop_cardlist._update_all_pricetag()
	#SETUP visual card 
		# sprite
		# avialable
		# soldout
		# censor
	#update buy n sell btn
	#update amount
	
	shop_cardlist._update_all_slot_visual_n_btn()



###needed fix
#func _slot_cardlist(codename:String, node_sprite:Sprite2D, node_price:Label, node_amount:Label):
	###texture
	#node_sprite.texture = load("res://Cards/CardSprite/%s.png" % codename)
	#
	####price
	#node_price.text = "$"+str(GlobalData.price_dict[codename])
	#
	###amount copy
	#node_amount.text = "x" + str(GlobalData.collection_arr.count(codename))
	#
	###available?
	## cu 90%
	#if GlobalData.common_arr.has(codename) or GlobalData.uncommon_arr.has(codename):
		#var rng = randi_range(1,10)
		#if rng == 1:
			##out of stock
			#pass
		#else:
			##add to shop_arr
			#GlobalData.shop_arr.append(codename)
	## rare 75%
	#elif GlobalData.rare_arr.has(codename):
		#var rng = randi_range(1,4)
		#if rng == 1:
			##out of stock
			#pass
		#else:
			#GlobalData.shop_arr.append(codename)
	#
	##temp visible
	#if GlobalData.shop_arr.has(codename):
		#pass
	#else:
		#node_sprite.visible = false
