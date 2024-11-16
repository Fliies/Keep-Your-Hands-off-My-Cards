extends Control

@onready var sprite:= $HBoxContainer/CardSprite/Sprite
@onready var censor:= $HBoxContainer/CardSprite/Censor
@onready var pricetag:= $HBoxContainer/CardSprite/Pricetag
@onready var price_lbl:= $HBoxContainer/CardSprite/Pricetag/PriceLbl
@onready var buy_btn:= $HBoxContainer/CardInfo/VBoxContainer/BuyBtn
@onready var sell_btn:= $HBoxContainer/CardInfo/VBoxContainer/SellBtn
@onready var amount_lbl:= $HBoxContainer/CardInfo/VBoxContainer/Copy/AmountLbl

signal buy(Control)
signal sell(Control)


func _on_buy_btn_pressed() -> void:
	buy.emit(self)


func _on_sell_btn_pressed() -> void:
	sell.emit(self)
