extends Control

class_name ShopOffer

signal buy_offer_finished

@onready var timer: Timer = $"../Timer"
@onready var animation_player: AnimationPlayer = $"../OwnerSprite/AnimationPlayer"


@onready var promo_sprite: Texture2D = load("res://Cards/CardSprite/ex_promo.png")
@export var node_promo_sprite: TextureRect
@export var promo_lbl: Label

@export var buy_offer_btn: Button
@export var buy_offer_lbl: Label

@export var btm_lbl: Label

func _ready() -> void:
	if GlobalData.shop_promo == true:
		node_promo_sprite.position = Vector2(40,30)
		node_promo_sprite.scale = Vector2(0.8,0.8)
		node_promo_sprite.texture = promo_sprite

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
	# - money
	GlobalData.money_current -= GlobalData.price_box
	#disable offer_btn in menu
	buy_offer_btn.disabled = true
	SoundManager._play_handle_money()
	timer.start(0.5)
	await timer.timeout
	SoundManager._acquired_card()
	
	animation_player.play("buy_offer")
	
	timer.start(2.0)
	
	#set global shop_promo = false
	GlobalData.shop_promo = false
	#disable buy_offer btn
	buy_offer_btn.disabled = true
	buy_offer_btn.visible = false
	
	#update buy_offer lbl to "THANK YOU"
	buy_offer_lbl.visible = false
	promo_lbl.visible = false
	
	await timer.timeout
	
	promo_lbl.text = "T H A N K  Y O U !"
	promo_lbl.visible = true
	
	animation_player.play("owner_idle")
	
	# + card packs
	GlobalData.packcount_single += 2
	GlobalData.packcount_box += 10
	# + promo card
	GlobalData.collection_arr.append("ex_promo")
	
	#update card sprite to soldout
	node_promo_sprite.texture = load("res://Cards/CardSprite/card-soudout-2.png")
	
	#change base shop BG
	buy_offer_finished.emit()

##HOVER
func _on_buy_offer_btn_mouse_entered() -> void:
	if buy_offer_btn.disabled == false:
		print(1)
		SoundManager._shop_offer_sfx()
