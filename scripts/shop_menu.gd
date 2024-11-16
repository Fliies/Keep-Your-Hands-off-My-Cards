extends Control

@onready var promo: bool = true

func _process(_delta: float) -> void:
	##shop MENU btn
	_update_shop_btn()


##SHOP MENU
func _update_shop_btn():
	##promo btn
	if promo == true:
		%OfferBtn.disabled = false
	else:
		%OfferBtn.disabled = true
	
	##packs btn
	#1pack btn
	if GlobalData.money_current >= GlobalData.price_pack:
		%Buy1Pack.disabled = false
	else:
		%Buy1Pack.disabled = true
	#5 packs btn
	if GlobalData.money_current >= (GlobalData.price_pack * 5):
		%Buy5Packs.disabled = false
	else:
		%Buy5Packs.disabled = true
	#box
	if GlobalData.money_current >= GlobalData.price_box:
		%BuyBox.disabled = false
	else:
		%BuyBox.disabled = true

#Buy and Sell BTN
func _on_buy_1_pack_pressed() -> void:
	# - money
	GlobalData.money_current -= GlobalData.price_pack
	#add pack
	GlobalData.packcount_single += 1
func _on_buy_5_packs_pressed() -> void:
	# - money
	GlobalData.money_current -= (GlobalData.price_pack * 5)
	#add pack
	GlobalData.packcount_single += 5
func _on_buy_box_pressed() -> void:
	# - money
	GlobalData.money_current -= GlobalData.price_box
	#add pack
	GlobalData.packcount_single += 2
	GlobalData.packcount_box += 10
