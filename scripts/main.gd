extends Node2D

signal animation_finished
signal show_cardback
signal complete_check_finished
signal pack_wiggle

@export var to_shop_theme: Theme
@export var to_house_theme: Theme
@export var gassfee_lbl: Label
@export var call_mom_btn: Button
@export var ui_money_rect:TextureRect
@export var ui_money:Texture2D
@export var ui_credit: Texture2D
@export var options_btn: Button

@onready var failsafe_timer: Timer = $FailSafe/Timer

@onready var completed_count:int = 0

@onready var shop:= %Shop
@onready var shop_n_house_btn:= %ShopNHouseBtn
@onready var home_btn:= %HomeBtn
@onready var binder_btn:= %BinderBtn

@onready var main_action_btn:= %MainActionBtn
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

@onready var ui:= $UI

#@onready var credit_cutscene:= $CreditCutscene

#@onready var icon_seen:= %SeenSprite
@onready var icon_collected:= %CollectedSprite


func _ready() -> void:
	Options.connect("options_back", _on_options_back_pressed)
	
	#idle pack sound
	connect("pack_wiggle", _idle_cardpack_sfx)
	
	_main_setup()

func _main_setup():
	##credit
	#credit_cutscene.visible = false
	
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
	shop_n_house_btn.visible = false #temp
	gassfee_lbl.visible = false
	
	call_mom_btn.disabled = true
	
	%HintLbl.visible = false
	
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
	
	##CHECKing
	if GlobalData.newgame == true:
		##new game
		GlobalData.newgame = false
		#no debt
		GlobalData.debt = false
		#no completed
		GlobalData.completed = false
		#no driver
		GlobalData.driver = false
		#Yes shop promo
		GlobalData.shop_promo = true
		#pack open
		GlobalData.total_open_packcount = 0
		#start arr
		GlobalData.starting_arr = true
		#clear collection
		GlobalData.collection_arr.clear()
		#clear open_arr
		GlobalData.opening_arr.clear()
		#clear seen_arr
		GlobalData.seen_arr.clear()
		#add starting pack
		GlobalData.packcount_box = 0
		GlobalData.packcount_box = GlobalData.STARTING_packs
		GlobalData.packcount_single = 0
		#add starting money
		GlobalData.money_current = GlobalData.STARTING_money
		#clear add_money
		GlobalData.money_added = 0
		#state
		GlobalStateController.prev_state = GlobalStateController.GameState.STANDBY
	else:
		#continue
		pass

func _process(_delta: float) -> void:
	##debug 
	_debug_process()
	
	##OPTIONS BTN
	if GlobalStateController.current_state == GlobalStateController.GameState.STANDBY:
		options_btn.disabled = false 
	elif GlobalStateController.current_state == GlobalStateController.GameState.SHOP_MENU:
		options_btn.disabled = false 
	elif GlobalStateController.current_state == GlobalStateController.GameState.SHOP_OFFER:
		options_btn.disabled = false 
	elif GlobalStateController.current_state == GlobalStateController.GameState.SHOP_CARDLIST:
		options_btn.disabled = false 
	else:
		options_btn.disabled = true 
	
	##DEBT btn and money
	if GlobalData.debt == false:
		ui_money_rect.texture = ui_money
		if GlobalData.money_current <= 3:
			if GlobalStateController.current_state == GlobalStateController.GameState.STANDBY:
				call_mom_btn.disabled = false
			elif GlobalStateController.current_state == GlobalStateController.GameState.BINDER:
				call_mom_btn.disabled = false
			elif GlobalStateController.current_state == GlobalStateController.GameState.SHOP_MENU:
				call_mom_btn.disabled = false
			elif GlobalStateController.current_state == GlobalStateController.GameState.SHOP_OFFER:
				call_mom_btn.disabled = false
			elif GlobalStateController.current_state == GlobalStateController.GameState.SHOP_CARDLIST:
				call_mom_btn.disabled = false
			elif GlobalStateController.current_state == GlobalStateController.GameState.ANIMATION:
				call_mom_btn.disabled = true
		else:
			call_mom_btn.disabled = true
	else:
		ui_money_rect.texture = ui_credit
		if GlobalData.money_current <= 100:
			GlobalData.money_current = GlobalData.money_mom
	
	##BINDER BTN
	if GlobalStateController.current_state == GlobalStateController.GameState.ANIMATION:
		#binder_btn.visible = false
		binder_btn.disabled = true
	else:
		binder_btn.visible = true
		binder_btn.disabled = false
	
	##to SHOP n HOUSE btn
	if GlobalStateController.current_state == GlobalStateController.GameState.STANDBY:
		if GlobalData.debt == false:
			if (GlobalData.money_current + GlobalData.money_added) <= 3:
				shop_n_house_btn.disabled = true
				shop_n_house_btn.visible = true
				gassfee_lbl.visible = false
			else:
				shop_n_house_btn.disabled = false
				shop_n_house_btn.visible = true
				gassfee_lbl.visible = true
		else:
			shop_n_house_btn.disabled = false
			shop_n_house_btn.visible = true
			gassfee_lbl.visible = true
	elif GlobalStateController.current_state == GlobalStateController.GameState.BINDER:
		shop_n_house_btn.disabled = true
		shop_n_house_btn.visible = false
		gassfee_lbl.visible = false
	elif GlobalStateController.current_state == GlobalStateController.GameState.ANIMATION:
		shop_n_house_btn.disabled = true
		shop_n_house_btn.visible = false
		gassfee_lbl.visible = false
	elif GlobalStateController.current_state == GlobalStateController.GameState.OPENING_BACK:
		shop_n_house_btn.disabled = true
		shop_n_house_btn.visible = false
		gassfee_lbl.visible = false
	elif GlobalStateController.current_state == GlobalStateController.GameState.OPENING_FRONT:
		shop_n_house_btn.disabled = true
		shop_n_house_btn.visible = false
		gassfee_lbl.visible = false
	elif GlobalStateController.current_state == GlobalStateController.GameState.SHOP_MENU:
		shop_n_house_btn.disabled = false
		shop_n_house_btn.visible = true
		gassfee_lbl.visible = false
	elif GlobalStateController.current_state == GlobalStateController.GameState.SHOP_OFFER:
		shop_n_house_btn.disabled = false
		shop_n_house_btn.visible = true
		gassfee_lbl.visible = false
	elif GlobalStateController.current_state == GlobalStateController.GameState.SHOP_CARDLIST:
		shop_n_house_btn.disabled = false
		shop_n_house_btn.visible = true
		gassfee_lbl.visible = false
	
	
	
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
		if _seen_n_collected_icon() == true:
			icon_collected.visible = true
		else:
			icon_collected.visible = false
	else:
		icon_collected.visible = false

	
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

func _seen_n_collected_icon() -> bool:
	var colllected:= false
	##collected
	if card_display.card_stat.card_codename in GlobalData.collection_arr:
		colllected = true
	
	return colllected


##signal
func _show_cardback():
	show_cardback.emit()
func _animation_finished():
	animation_finished.emit()

##binder
func _on_binder_btn_pressed() -> void:
	_binder_handle()
func _binder_handle():
	SoundManager._play_sfx_random_pitch(SoundManager.binder, 0.0)
	if binder_open == false:
		
		#halt state
		GlobalStateController.prev_state = GlobalStateController.current_state
		GlobalStateController.current_state = GameStateController.GameState.BINDER
		
		##update binder
		if GlobalData.completed == true:
			var count = 0
			for codename in GlobalData.completed_arr:
				if GlobalData.collection_arr.has(codename):
					count += 1
			binder._update_completed(count)
			
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
	SoundManager._play_ui_click()
	
	##driver 1st time 
	if GlobalData.driver == false:
		GlobalStateController.current_state = GlobalStateController.GameState.ANIMATION
		GlobalData.driver = true
		##play animation
		binder._first_driver()
		
		##update cover
		await binder.animation_finished
		_completed_check()
		##await animation end
		await binder.first_driver
		GlobalStateController.current_state = GlobalStateController.GameState.STANDBY
	
	##to SHOP
	if GlobalStateController.current_state == GlobalStateController.GameState.STANDBY:
		SoundManager._play_sfx(SoundManager.motorcycle_to_shop, 0.0)
		
		shop_n_house_btn.disabled = true
		#gas fee
		GlobalData.money_current -= 3
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
	
	##to house
	elif GlobalStateController.current_state == GlobalStateController.GameState.SHOP_MENU or GlobalStateController.GameState.SHOP_OFFER or GlobalStateController.GameState.SHOP_CARDLIST:
		SoundManager._play_sfx(SoundManager.motorcycle_back_home, 0.0)
		
		shop_n_house_btn.disabled = true
		#animation transition
		GlobalStateController.current_state = GlobalStateController.GameState.ANIMATION
		shop.visible = false
		ScreenTransition.animation_player.play("BackFromShop_transition")
		
		await ScreenTransition.animation_finished
		GlobalStateController.current_state = GlobalStateController.GameState.STANDBY
		shop_n_house_btn.theme = to_shop_theme
	else:
		print("err")


##completed
func _completed_check():
	
	completed_count = 0
	
	for codename in GlobalData.codename_arr:
		if GlobalData.collection_arr.has(codename):
			completed_count += 1
	
	if completed_count >= 26:
		if GlobalData.collection_arr.has("ex_misprint"):
			completed_count += 1
		if GlobalData.collection_arr.has("ex_promo"):
			completed_count += 1
		if GlobalData.collection_arr.has("ex_driver"):
			completed_count += 1
		if GlobalData.collection_arr.has("ex_credit"):
			completed_count += 1
	
	if GlobalData.completed == false:
		if completed_count == 26:
			binder_open = true
			binder._first_completed(26)
		elif completed_count == 27:
			binder_open = true
			binder._first_completed(27)
		elif completed_count == 28:
			binder_open = true
			binder._first_completed(28)
		elif completed_count == 29:
			binder_open = true
			binder._first_completed(29)
		elif completed_count == 30:
			binder_open = true
			binder._first_completed(30)
		
		#complete_check_finished.emit()
	else:
		binder._update_completed(completed_count)
		
		#complete_check_finished.emit()
	
	complete_check_finished.emit()

func _on_shop_buy_card() -> void:
	_completed_check()


##call Mom
func _on_call_mom_btn_pressed() -> void:
	GlobalStateController.prev_state = GlobalStateController.current_state
	GlobalStateController.current_state = GameStateController.GameState.ANIMATION
	##open binder to 1st page
	
	##animation
	binder._first_callmom()
	await binder.credit_to_slot_finished
	_completed_check()
	##set DEBT
	GlobalData.debt = true
	ui_money_rect.z_index = 5
	ui_money_rect.size = Vector2(200,200)
	await binder.callmom_finished
	ui_money_rect.z_index = 0
	ui_money_rect.size = Vector2(100,100)
	
	call_mom_btn.disabled = true
	
	GlobalStateController.current_state = GlobalStateController.prev_state 



##DEBUG
func _debug_process():
	$UI/debug._count_all() #card count 
	$UI/debug/packamount.text = (
	" box: " + str(GlobalData.packcount_box)
	+ " single: " + str(GlobalData.packcount_single)
	+ " = " + str(GlobalData.packcount_box + GlobalData.packcount_single) #pack amount
	+ " OPEN: " + str(GlobalData.total_open_packcount)
	)
	#if Input.is_action_just_pressed("quick_add_pack"): #quick add pack
		#GlobalData.packcount_box += 1


func _on_main_action_btn_keep_finished() -> void:
	#print(0)
	_completed_check()
	#print(1)
	await complete_check_finished
	#print(2)
	if Options.auto_flip == true:
		if GlobalData.opening_arr.size() != 0:
			main_action_btn._flip_card()
			#print("FLIP")
	
	###fail safe
	#_failsafe_autoflip()
	##print("PASS")

func _on_main_action_btn_sell_finished() -> void:
	if GlobalStateController.current_state == GlobalStateController.GameState.OPENING_BACK:
		if Options.auto_flip == true:
			main_action_btn._flip_card()

func _on_main_action_btn_open_pack_finished() -> void:
	if Options.auto_flip == true:
		main_action_btn._flip_card()


##options BTN
func _on_options_btn_pressed() -> void:
	ui.visible = false
	
	Options._options_main()

func _on_options_back_pressed():
	ui.visible = true


##idle pack sound
func _pack_wiggle():
	pack_wiggle.emit()

func _idle_cardpack_sfx():
	if GlobalStateController.current_state == GlobalStateController.GameState.STANDBY:
		$Animation/CardPackWiggle.pitch_scale = randf_range(0.8,1.2)
		
		$Animation/CardPackWiggle.play()
	else:
		$Animation/CardPackWiggle.stop()
