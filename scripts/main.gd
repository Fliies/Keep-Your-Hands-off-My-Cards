extends Node2D

signal animation_finished
signal show_cardback

@export var to_shop_theme: Theme
@export var to_house_theme: Theme
@export var gassfee_lbl: Label

@onready var shop:= %Shop
@onready var shop_n_house_btn:= %ShopNHouseBtn
@onready var home_btn:= %HomeBtn
@onready var binder_btn:= %BinderBtn

#@onready var action_btn:= %MainActionBtn
@onready var btn_open_pack:= %OpenPack
@onready var btn_sell:= %SellBtn
@onready var btn_keep:= %KeepBtn
@onready var btn_flip:= %FlipBtn

@onready var card_display:= %CardDisplay

@onready var pack_sprite:= %PackSprite
@onready var hand_sprite:= %HandSprite
@onready var cardback_hand:= %CardBackHand

@onready var animation_player_main:= %MainPlayer
@onready var animation_player_aux:= %AuxPlayer

@onready var binder_open: bool = false
@onready var binder:= %Binder

@onready var ui:= %UI

#@onready var icon_seen:= %SeenSprite
@onready var icon_collected:= %CollectedSprite

func _setup_check():
	if GlobalData.newgame == true:
		##new game
		GlobalData.newgame = false
		#clear collection
		GlobalData.collection_arr.clear()
		#add starting pack
		GlobalData.packcount_box = GlobalData.STARTING_packs
		#add starting money
		GlobalData.money_current = GlobalData.STARTING_money
	else:
		#continue
		pass

func _ready() -> void:
	_setup_check()
	
	##BTN
	btn_open_pack.visible = false
	btn_keep.visible = false
	btn_sell.visible = false
	btn_flip.visible = false
	
	btn_open_pack.disabled = true
	btn_keep.disabled = true
	btn_sell.disabled = true
	btn_flip.disabled = true
	
	shop_n_house_btn.theme = to_shop_theme
	shop_n_house_btn.visible = true #temp
	gassfee_lbl.visible = false
	
	##hand and pack
	pack_sprite.visible = false
	hand_sprite.visible = false
	cardback_hand.visible = false
	
	##card_display
	$CardDisplay/CardBackSprite2.visible = false
	$CardDisplay/CardBackSprite.visible = false
	$CardDisplay/CardSprite.visible = false
	
	##animation
	$Animation/OpenPack.visible = false
	
	##SHOP
	shop.visible = false

func _process(_delta: float) -> void:
	##debug 
	_debug_process()
	
	##BINDER BTN
	if GlobalStateController.current_state == GlobalStateController.GameState.ANIMATION:
		binder_btn.visible = false
		binder_btn.disabled = true
	else:
		binder_btn.visible = true
		binder_btn.disabled = false
	
	#to SHOP n HOUSE btn
	if GlobalStateController.current_state == GlobalStateController.GameState.STANDBY:
		gassfee_lbl.visible = true
	else:
		gassfee_lbl.visible = false
	if GlobalStateController.current_state == GlobalStateController.GameState.BINDER:
		shop_n_house_btn.disabled = true
		shop_n_house_btn.visible = false
		#gassfee_lbl.visible = false
	elif GlobalStateController.current_state == GlobalStateController.GameState.ANIMATION:
		shop_n_house_btn.disabled = true
		shop_n_house_btn.visible = false
		#gassfee_lbl.visible = false
	elif GlobalStateController.current_state == GlobalStateController.GameState.OPENING_BACK:
		shop_n_house_btn.disabled = true
		shop_n_house_btn.visible = false
		#gassfee_lbl.visible = false
	elif GlobalStateController.current_state == GlobalStateController.GameState.OPENING_FRONT:
		shop_n_house_btn.disabled = true
		shop_n_house_btn.visible = false
		#gassfee_lbl.visible = false
	else:
		shop_n_house_btn.disabled = false
		shop_n_house_btn.visible = true
		#gassfee_lbl.visible = true
	
	##open pack btn
	if GlobalStateController.current_state == GlobalStateController.GameState.STANDBY:
		if GlobalData.packcount_box != 0 or GlobalData.packcount_single != 0:
			btn_open_pack.visible = true
			btn_open_pack.disabled = false
			
			hand_sprite.visible = true
			pack_sprite.visible = true
			
			#idle animation
			animation_player_main.play("pack_loop_2")
		elif GlobalData.packcount_box == 0 and GlobalData.packcount_single == 0:
			btn_open_pack.visible = false
			btn_open_pack.disabled = true
			
			hand_sprite.visible = false
			pack_sprite.visible = false
			
			#go to shop noti
			
	else:
		btn_open_pack.visible = false
		btn_open_pack.disabled = true
	
	##COLLECTED ICON
	if GlobalStateController.current_state == GlobalStateController.GameState.OPENING_FRONT:
		##seen icon
		_seen_n_collected_icon()
	else:
		icon_collected.visible = false
		#icon_seen.visible = false
	
	# idle animation
	if GlobalStateController.current_state == GlobalStateController.GameState.OPENING_BACK:
		animation_player_aux.play("idle_cardback")
	elif GlobalStateController.current_state == GlobalStateController.GameState.OPENING_FRONT:
		animation_player_aux.play("idle_cardfront")
	else:
		animation_player_aux.stop()


##Seen 
func _seen_count():
	GlobalData.seen_arr.append(card_display.card_stat.card_codename)

func _seen_n_collected_icon():
	###seen
	#if card_display.card_stat.card_codename in GlobalData.seen_arr:
		#icon_seen.visible = true
	#else:
		#icon_seen.visible = false
	
	##collected
	if card_display.card_stat.card_codename in GlobalData.collection_arr:
		icon_collected.visible = true
	else:
		icon_collected.visible = false


##signal
func _show_cardback():
	show_cardback.emit()
func _animation_finished():
	animation_finished.emit()

##binder
func _on_binder_btn_pressed() -> void:
	_binder_handle()
func _binder_handle():
	if binder_open == false:
		
		#halt state
		GlobalStateController.prev_state = GlobalStateController.current_state
		GlobalStateController.current_state = GameStateController.GameState.BINDER
		
		##update binder
		#slot visual
		binder._update_all_slot_visual()
		#inspect btn
		binder._update_inspect_btn_whole_page(binder.current_page)
		
		binder._update_price_sheet()
		
		binder.visible = true
		binder_open = true
		
	#open -> close
	else:
		binder.visible = false
		binder_open = false
		
		GlobalStateController.current_state = GlobalStateController.prev_state

##shop BTN
func _on_shop_n_house_btn_pressed() -> void:
	##driver 1st time 
	if GlobalData.driver == false:
		GlobalData.driver = true
		pass
	
	
	##to SHOP
	if GlobalStateController.current_state == GlobalStateController.GameState.STANDBY:
		shop_n_house_btn.disabled = true
		#setup shop
		shop._enter_shop()
		GlobalStateController.current_state = GlobalStateController.GameState.ANIMATION
		#animation transition
		ScreenTransition.animation_player.play("toShop_transition")
		
		await ScreenTransition.new_scene
		shop.visible = true
		
		await ScreenTransition.animation_finished
		GlobalStateController.current_state = GlobalStateController.GameState.SHOP_MENU
		shop_n_house_btn.theme = to_house_theme
		gassfee_lbl.visible = false
		shop_n_house_btn.disabled = false
	
	##to house
	elif GlobalStateController.current_state == GlobalStateController.GameState.SHOP_MENU or GlobalStateController.GameState.SHOP_OFFER or GlobalStateController.GameState.SHOP_CARDLIST:
		shop_n_house_btn.disabled = true
		#animation transition
		GlobalStateController.current_state = GlobalStateController.GameState.ANIMATION
		shop.visible = false
		ScreenTransition.animation_player.play("BackFromShop_transition")
		
		#await ScreenTransition.new_scene
		
		await ScreenTransition.animation_finished
		GlobalStateController.current_state = GlobalStateController.GameState.STANDBY
		shop_n_house_btn.theme = to_shop_theme
		gassfee_lbl.visible = true
		shop_n_house_btn.disabled = false
	else:
		print("err")


##completed
func _completed_check():
	var count = 0
	for codename in GlobalData.completed_arr:
		if GlobalData.collection_arr.has(codename):
			count += 1
	
	if GlobalData.completed == false:
		if count == 27:
			_binder_completed()
			binder._first_completed(27)
		elif count == 28:
			_binder_completed()
			binder._first_completed(28)
		elif count == 29:
			_binder_completed()
			binder._first_completed(29)
		elif count == 30:
			_binder_completed()
			binder._first_completed(30)
	else:
		binder._update_completed(count)

##compulsary open BINDER
func _binder_completed():
	GlobalStateController.prev_state = GlobalStateController.current_state
	GlobalStateController.current_state = GameStateController.GameState.ANIMATION
	
	binder._update_price_sheet()
	
	binder.visible = true
	binder_open = true
	
	###update binder
	#binder.current_page = 4
	##slot visual
	#binder._update_all_slot_visual()
	##inspect btn
	#binder._update_inspect_btn_whole_page(binder.current_page)
	


##DEBUG
func _debug_process():
	$UI/debug._count_all() #card count 
	$UI/debug/packamount.text = (
	" box: " + str(GlobalData.packcount_box)
	+ " single: " + str(GlobalData.packcount_single)
	+ " = " + str(GlobalData.packcount_box + GlobalData.packcount_single) #pack amount
	+ " OPEN: " + str(GlobalData.total_open_packcount)
	)
	if Input.is_action_just_pressed("quick_add_pack"): #quick add pack
		GlobalData.packcount_box += 1
