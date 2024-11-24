extends Control

class_name Shop

signal buy_card

@export_category("BG")
#@export var base_bg: Texture2D
@export var node_shop_bg: TextureRect
@export var node_shop_hilight: TextureRect

@export var shop_base_offer: Texture2D
@export var shop_base_sold: Texture2D
@export var shop_offer_hilight: Texture2D
@export var shop_pack_hilight: Texture2D
@export var shop_box_hilight: Texture2D
@export var shop_trading_hilight: Texture2D

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
	
	shop_menu.visible = true
	
	shop_cardlist.visible = false
	shop_offer.visible = false
	
	text_idle.visible = true
	text_dyn.visible = false
	
	##BG n Hilight
	#base shop bg -> offer
	node_shop_bg.texture = shop_base_offer
	#hilight bg -> null
	node_shop_hilight.texture = null



## ENTER THE SHOP
func _enter_shop() -> void:
	##ENTER the SHOP
	if GlobalStateController.current_state == GlobalStateController.GameState.STANDBY:
		# menu visible
		shop_cardlist.visible = false
		shop_offer.visible = false
		shop_menu.visible = true
		# add sell money
		GlobalData.money_current += GlobalData.money_added
		GlobalData.money_added = 0
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


##OFFER STUFFS
#offerBTN in menu
func _on_offer_btn_pressed() -> void:
	GlobalStateController.current_state = GlobalStateController.GameState.SHOP_OFFER
	shop_menu.visible = false
	shop_offer.visible = true
	
	#hilight
	node_shop_hilight.texture = shop_offer_hilight

#BUY OFFER
func _on_buy_offer_btn_pressed() -> void:
	#disable offer_btn in menu
	shop_offer_btn.disabled = true
	#update visual
	#shop_offer_lbl.visible = false
	#shop_offer_lbl.text = "restock date: TBD"
	shop_offer_lbl.label_settings.font_color = Color.WHITE_SMOKE
	shop_offer_lbl.label_settings.outline_size = 0
	
	
	#change base shop BG
	node_shop_bg.texture = shop_base_sold



#offer mouse in
func _on_offer_btn_mouse_entered() -> void:
	if GlobalStateController.current_state == GlobalStateController.GameState.SHOP_MENU:
		##text
		text_idle.visible = false
		text_dyn.visible = true
		
		text_dyn_up.text = "SPECIAL DEAL!"
		text_dyn_low.label_settings.font_color = Color.ORANGE
		#soldout
		if GlobalData.shop_promo == false:
			text_dyn_low.text = "restock date: TBD"
		else:
			text_dyn_low.text = "LIMITED AMOUNT!"
		##hilight
		#check promo
		#if GlobalData.shop_promo == true:
			#assign sprite
		node_shop_hilight.texture = shop_offer_hilight

#offer mouse out
func _on_offer_btn_mouse_exited() -> void:
	##text
	_mouse_out()
	##unhilight
	node_shop_hilight.texture = null

#offer backBtn
func _on_offer_back_btn_pressed() -> void: 
	#visiblility
	shop_menu.visible = true
	shop_offer.visible = false
	#GameState
	GlobalStateController.current_state = GlobalStateController.GameState.SHOP_MENU
	#unhilight
	node_shop_hilight.texture = null


##TRADING cardList STUFFS
#TRADING BTN in Menu
func _on_shop_cardlist_btn_pressed() -> void:
	GlobalStateController.current_state = GlobalStateController.GameState.SHOP_CARDLIST
	#visiblility
	shop_menu.visible = false
	shop_cardlist.visible = true
	
	#hilight
	node_shop_hilight.texture = shop_trading_hilight

#trading mouse in
func _on_shop_cardlist_btn_mouse_entered() -> void:
	if GlobalStateController.current_state == GlobalStateController.GameState.SHOP_MENU:
		##text
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
			"I <3 MOO DENG",
			"we have 'SECRET' in store!",
			"luck be on your side!",
			"next pack will have 'SECRET', THRUST ME!"
		]
		
		text_dyn_up.text = "BUY / SELL CARDS"
		text_dyn_low.label_settings.font_color = Color.LIGHT_CORAL
		text_dyn_low.text = yap.pick_random()
		
		##hilight
		node_shop_hilight.texture = shop_trading_hilight

#trading mouse out
func _on_shop_cardlist_btn_mouse_exited() -> void:
	##text
	_mouse_out()
	##unhilight
	node_shop_hilight.texture = null

#trading backBTN
func _on_cardlist_back_btn_pressed() -> void: 
	#visiblility
	shop_menu.visible = true
	shop_cardlist.visible = false
	#GameState
	GlobalStateController.current_state = GlobalStateController.GameState.SHOP_MENU
	#unhilight
	node_shop_hilight.texture = null


##mouse in
#pack
func _on_buy_1_pack_mouse_entered() -> void:
	if GlobalStateController.current_state == GlobalStateController.GameState.SHOP_MENU:
		##text
		text_idle.visible = false
		text_dyn.visible = true
		
		text_dyn_up.text = "BUY 1 PACK"
		text_dyn_low.label_settings.font_color = Color.FOREST_GREEN
		text_dyn_low.text = "for $10"
		
		##hilight
		node_shop_hilight.texture = shop_pack_hilight
func _on_buy_5_packs_mouse_entered() -> void:
	if GlobalStateController.current_state == GlobalStateController.GameState.SHOP_MENU:
		##text
		text_idle.visible = false
		text_dyn.visible = true
		
		text_dyn_up.text = "BUY 5 PACKS"
		text_dyn_low.label_settings.font_color = Color.FOREST_GREEN
		text_dyn_low.text = "for $50"
		
		##hilight
		node_shop_hilight.texture = shop_pack_hilight
#box
func _on_buy_box_mouse_entered() -> void:
	if GlobalStateController.current_state == GlobalStateController.GameState.SHOP_MENU:
		##text
		text_idle.visible = false
		text_dyn.visible = true
		
		text_dyn_up.text = "BUY 1 BOX"
		text_dyn_low.label_settings.font_color = Color.FIREBRICK
		text_dyn_low.text = "10+2 packs for only $90!"
		
		##hilight
		node_shop_hilight.texture = shop_box_hilight

##mouse out
func _mouse_out():
	text_idle.visible = true
	text_dyn.visible = false
	text_dyn_low.label_settings.font_color = Color.BLACK
#pack
func _on_buy_1_pack_mouse_exited() -> void:
	##text
	_mouse_out()
	##unhilight
	node_shop_hilight.texture = null
func _on_buy_5_packs_mouse_exited() -> void:
	##text
	_mouse_out()
	##unhilight
	node_shop_hilight.texture = null
#box
func _on_buy_box_mouse_exited() -> void:
	##text
	_mouse_out()
	##unhilight
	node_shop_hilight.texture = null


func _on_shop_cardlist_buy_card() -> void:
	#for COMPLETE CHECK
	buy_card.emit()
