extends Node2D

@export var card_stat: CardStats
#@onready var card_stat_next: CardStats

@onready var main:= get_parent()

@onready var card_sprite:= $CardSprite
@onready var cardback:= $CardBackSprite
@onready var cardback_next:= $CardBackSprite2
@onready var card_area:= $CardArea
@onready var mouse_enter: bool = false
@onready var flipable: bool = true

func _ready() -> void:
	cardback.texture = load("res://Cards/CardSprite/cardback.png")
	cardback_next.texture = load("res://Cards/CardSprite/cardback.png")

func _process(_delta: float) -> void:
	#hidden in STANDBY
	if GlobalStateController.current_state == GlobalStateController.GameState.STANDBY:
		await main.animation_finished
		self.visible = false
	#show in OPENING
	if GlobalStateController.current_state == GlobalStateController.GameState.OPENING_BACK:
		self.visible = true
	
	
	#_last_card()

func _last_card():
	if GlobalData.opening_arr.size() <= 1:
		cardback_next.visible = false
	else:
		cardback_next.visible = true

##UPDATE
func _update_all():
	if GlobalData.opening_arr.size() != 0:
		self.visible = true
		#set up cardstat + assign rarity / sprite
		_assign_cardstat()
		#update price
		_update_price()
		#update visual
		_update_sprite()

#assign card stat
func _assign_cardstat():
	#check open arr not empty
	#set card stat
	if GlobalData.opening_arr.size() != 0:
		var card = GlobalData.opening_arr[0]
		card_stat = load("res://Cards/card_%s.tres" % card)
	
	_assign_rarity()
	_assign_sprite()

func _assign_rarity():
	if card_stat.card_rarity_enum == 0: card_stat.card_rarity = "COMMON"
	if card_stat.card_rarity_enum == 1: card_stat.card_rarity = "UNCOMMON"
	if card_stat.card_rarity_enum == 2: card_stat.card_rarity = "RARE"
	if card_stat.card_rarity_enum == 3: card_stat.card_rarity = "SECRET"
	if card_stat.card_rarity_enum == 4: card_stat.card_rarity = "EXTRA"

func _assign_sprite():
	card_stat.card_back = load("res://Cards/CardSprite/cardback.png")
	card_stat.card_sprite = load ("res://Cards/CardSprite/%s.png" % card_stat.card_codename)


func _update_sprite():
	#reset all false
	cardback.visible = false
	card_sprite.visible = false
	
	##topcard
	#show card back
	cardback.scale = Vector2(1,1)
	cardback.visible = true
	
	#hide card sprite
	card_sprite.visible = false
	card_sprite.texture = card_stat.card_sprite

func _update_price():
	if card_stat.card_rarity == "COMMON":
		card_stat.card_price = GlobalData.PRICE_COMMON.pick_random()
	elif card_stat.card_rarity == "UNCOMMON":
		card_stat.card_price = GlobalData.PRICE_UNCOMMON.pick_random()
	elif card_stat.card_rarity == "RARE":
		card_stat.card_price = GlobalData.PRICE_RARE.pick_random()
	elif card_stat.card_rarity == "SECRET":
		card_stat.card_price = GlobalData.PRICE_SECRET.pick_random()
	elif card_stat.card_rarity == "EXTRA":
		card_stat.card_price = GlobalData.PRICE_EXRTA.pick_random()



##FLIP MANAGER
func _on_card_area_mouse_entered() -> void:
	_mouse_enter()

func _on_card_area_mouse_exited() -> void:
	_mouse_exit()

func _mouse_enter():
	mouse_enter = true

func _mouse_exit():
	mouse_enter = false
