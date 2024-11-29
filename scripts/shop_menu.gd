extends Control

class_name ShopMenuButton

@onready var offer_btn:= %OfferBtn
@onready var buy_1_pack_btn:= %Buy1Pack
@onready var buy_5_pack_btn:= %Buy5Packs
@onready var buy_box_btn:= %BuyBox

func _process(_delta: float) -> void:
	##shop MENU btn
	if GlobalStateController.current_state == GlobalStateController.GameState.SHOP_MENU:
		_update_shop_btn()


##SHOP MENU
func _update_shop_btn():
	##promo btn
	if GlobalData.shop_promo == true:
		offer_btn.disabled = false
	else:
		offer_btn.disabled = true
	
	##packs btn
	#1pack btn
	if GlobalData.money_current >= GlobalData.price_pack:
		buy_1_pack_btn.disabled = false
	else:
		buy_1_pack_btn.disabled = true
	#5 packs btn
	if GlobalData.money_current >= (GlobalData.price_pack * 5):
		buy_5_pack_btn.disabled = false
	else:
		buy_5_pack_btn.disabled = true
	
	#box
	if GlobalData.shop_promo == true:
		buy_box_btn.disabled = true
	else:
		if GlobalData.money_current >= GlobalData.price_box:
			buy_box_btn.disabled = false
		else:
			buy_box_btn.disabled = true

#Buy and Sell BTN
func _on_buy_1_pack_pressed() -> void:
	SoundManager._play_handle_money()
	# - money
	GlobalData.money_current -= GlobalData.price_pack
	#add pack
	GlobalData.packcount_single += 1
func _on_buy_5_packs_pressed() -> void:
	SoundManager._play_handle_money()
	# - money
	GlobalData.money_current -= (GlobalData.price_pack * 5)
	#add pack
	GlobalData.packcount_single += 5
func _on_buy_box_pressed() -> void:
	SoundManager._play_handle_money()
	# - money
	GlobalData.money_current -= GlobalData.price_box
	#add pack
	GlobalData.packcount_single += 2
	GlobalData.packcount_box += 10
