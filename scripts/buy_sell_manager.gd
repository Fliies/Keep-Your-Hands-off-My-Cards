extends Control

@onready var promo: bool = false


func _process(_delta: float) -> void:
	_update_shop_btn()
	_update_cardlist_btn()

##function
func _buy_card(codename:String):
	GlobalData.shop_arr.erase(codename)
	GlobalData.collection_arr.append(codename)

func _sell_card(codename:String):
	GlobalData.collection_arr.erase(codename)
	GlobalData.shop_arr.append(codename)

func _btn_check(codename:String, buy_btn:Button, sell_btn:Button):
	##buy btn from money and shop_arr
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
	
	##sell btn from collection
	if GlobalData.collection_arr.has(codename):
		#can sell
		sell_btn.disabled = false
	else:
		#cannot sell
		sell_btn.disabled = true

func _update_cardlist_btn():
	#aa
	_btn_check("aa",%aaBuy,%aaSell)
	_btn_check("bb",%bbBuy,%bbSell)
	#_btn_check("cc",%ccBuy,%ccSell)
	#_btn_check("dd",%ddBuy,%ddSell)
	#_btn_check("ee",%eeBuy,%eeSell)
	#_btn_check("ff",%ffBuy,%ffSell)
	#_btn_check("gg",%ggBuy,%ggSell)
	#_btn_check("hh",%hhBuy,%hhSell)
	#_btn_check("ii",%iiBuy,%iiSell)
	#_btn_check("jj",%jjBuy,%jjSell)
	#_btn_check("kk",%kkBuy,%kkSell)
	#_btn_check("ll",%llBuy,%llSell)
	#_btn_check("mm",%mmBuy,%mmSell)
	#_btn_check("nn",%nnBuy,%nnSell)
	#_btn_check("oo",%ooBuy,%ooSell)
	#_btn_check("pp",%ppBuy,%ppSell)
	#_btn_check("qq",%qqBuy,%qqSell)
	#_btn_check("rr",%rrBuy,%rrSell)
	#_btn_check("ss",%ssBuy,%ssSell)
	#_btn_check("tt",%ttBuy,%ttSll)
	#_btn_check("uu",%uuBuy,%uuSell)
	#_btn_check("vv",%vvBuy,%vvSell)
	_btn_check("ww",%wwBuy,%wwSell)
	_btn_check("xx",%xxBuy,%xxSell)
	#_btn_check("yy",%yyBuy,%yySell)
	#_btn_check("zz",%zzBuy,%zzSell)

func _update_shop_btn():
	##promo
	if promo == true:
		%PromoBtn.disabled = false
	else:
		%PromoBtn.disabled = true
	
	##packs
	#1pack
	if GlobalData.money_current >= GlobalData.price_pack:
		%Buy1Pack.disabled = false
	else:
		%Buy1Pack.disabled = true
	#5 packs
	if GlobalData.money_current >= (GlobalData.price_pack * 5):
		%Buy5Packs.disabled = false
	else:
		%Buy5Packs.disabled = true
	#box
	if GlobalData.money_current >= GlobalData.price_box:
		%BuyBox.disabled = false
	else:
		%BuyBox.disabled = true



##Buy and Sell BTN
#PACKS
func _on_pack_pressed() -> void:
	# - money
	GlobalData.money_current -= GlobalData.price_pack
	#add pack
	GlobalData.packcount_single += 1
func _on_packs_pressed() -> void:
	# - money
	GlobalData.money_current -= (GlobalData.price_pack * 5)
	#add pack
	GlobalData.packcount_single += 5
func _on_box_pressed() -> void:
	# - money
	GlobalData.money_current -= GlobalData.price_box
	#add pack
	GlobalData.packcount_single += 2
	GlobalData.packcount_box += 10


func _on_aa_buy_pressed() -> void:
	_buy_card("aa")
func _on_aa_sell_pressed() -> void:
	_sell_card("aa")
