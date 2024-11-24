extends Control

@onready var sprite:= $HBoxContainer/CardSprite/Sprite
@onready var censor:= $HBoxContainer/CardSprite/Censor
@onready var pricetag:= $HBoxContainer/CardSprite/Pricetag
@onready var price_lbl:= $HBoxContainer/CardSprite/Pricetag/PriceLbl
@onready var buy_btn:= $HBoxContainer/CardSprite/BuyBtn
@onready var sell_btn:= $HBoxContainer/CardInfo/VBoxContainer/SellBtn
@onready var amount_lbl:= $HBoxContainer/CardInfo/VBoxContainer/SellBtn/AmountLbl
@onready var shop_amount_lbl:= $HBoxContainer/ShopAmount/ShopAmountLbl
@onready var animation_palyer:= $AnimationPlayer
@onready var stock_lbl:= $HBoxContainer/CardInfo/VBoxContainer/Stock/StockLbl

signal buy_cardlist_slot(Control)
signal sell_cardlist_slot(Control)
signal cannot_buy(Control)
signal mouse_in_sell
signal mouse_out_buy_btn
signal mouse_out_sell_btn
signal animation_finished

func _animation_finished():
	animation_finished.emit()

func _on_buy_btn_pressed() -> void:
	buy_btn.disabled = true
	animation_palyer.play("buy")
	
	await animation_finished
	buy_cardlist_slot.emit(self)

func _on_sell_btn_pressed() -> void:
	sell_btn.disabled = true
	#animation_palyer.play("sell")
	#
	#await animation_finished
	sell_cardlist_slot.emit(self)

##wiggle animation
func _price_wiggle_up():
	pricetag.rotation_degrees += 5
	pricetag.rotation_degrees = max(-10,10)
func _price_wiggle_down():
	pricetag.rotation_degrees -= 5
	pricetag.rotation_degrees = min(-10,10)

##mouse ENTER n EXIT
#buy btn
func _on_buy_btn_mouse_entered() -> void:
	if buy_btn.disabled == false:
		animation_palyer.play("price_wiggle")
	else:
		cannot_buy.emit(self)
func _on_buy_btn_mouse_exited() -> void:
	mouse_out_buy_btn.emit()
	if buy_btn.disabled == false:
		animation_palyer.stop()

#sell btn
func _on_sell_btn_mouse_entered() -> void:
	mouse_in_sell.emit(self)
	if sell_btn.disabled == false:
		animation_palyer.play("price_wiggle")
func _on_sell_btn_mouse_exited() -> void:
	mouse_out_sell_btn.emit()
	if sell_btn.disabled == false:
		animation_palyer.stop()
