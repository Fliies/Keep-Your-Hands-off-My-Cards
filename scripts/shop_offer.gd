extends Control

class_name ShopOffer

@onready var promo_sprite: Texture2D = load("res://Cards/CardSprite/ex_promo.png")
@export var node_promo_sprite: TextureRect
@export var promo_lbl: Label

@export var buy_offer_btn: Button
@export var buy_offer_lbl: Label

@export var btm_lbl: Label

func _process(_delta: float) -> void:
	if GlobalStateController.current_state == GameStateController.GameState.SHOP_OFFER:
		if GlobalData.shop_promo == true:
			if GlobalData.money_current >= 90:
				buy_offer_btn.disabled = false
			else:
				buy_offer_btn.disabled = true
		else:
			buy_offer_btn.disabled = true

func _on_buy_offer_btn_pressed() -> void:
	#set global shop_promo = false
	GlobalData.shop_promo = false
	#disable buy_offer btn
	buy_offer_btn.disabled = true
	buy_offer_btn.visible = false
	# - money
	GlobalData.money_current -= GlobalData.price_box
	# + card packs
	GlobalData.packcount_single += 2
	GlobalData.packcount_box += 10
	# + promo card
	GlobalData.collection_arr.append("ex_promo")
	
	#update buy_offer lbl to "THANK YOU"
	buy_offer_lbl.visible = false
	#buy_offer_lbl.text = "you got the last PROMO!"
	promo_lbl.text = "T H A N K  Y O U !"
	#update card sprite to soldout
	node_promo_sprite.texture = load("res://Cards/CardSprite/card-soudout-2.png")
	
