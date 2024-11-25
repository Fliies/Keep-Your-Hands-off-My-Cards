extends Control

@onready var main:= get_parent().get_parent()

@onready var sell_btn:= %SellBtn
@onready var sell_price:= %SellPrice
@onready var keep_btn:= %KeepBtn
@onready var flip_btn:= %FlipBtn

signal sell_finished
signal keep_finished
signal open_pack_finished

func _process(_delta: float) -> void:
	##SELL n KEEP btn
	if GlobalStateController.current_state == GlobalStateController.GameState.OPENING_FRONT:
		sell_btn.visible = true
		sell_btn.disabled = false
		
		keep_btn.visible = true
		keep_btn.disabled = false
	else:
		sell_btn.visible = false
		sell_btn.disabled = true
		
		keep_btn.visible = false
		keep_btn.disabled = true
	
	##FLIP btn
	if GlobalStateController.current_state == GlobalStateController.GameState.OPENING_BACK:
		flip_btn.visible = true
		flip_btn.disabled = false
	else:
		flip_btn.visible = false
		flip_btn.disabled = true


##OPEN PACK
func _on_open_pack_pressed() -> void:
	#change GameState
	GlobalStateController.current_state = GlobalStateController.GameState.ANIMATION
	#hide btn
	main.btn_open_pack.disabled = true
	main.btn_open_pack.visible = false
	
	#pack count +1
	GlobalData.total_open_packcount += 1
	
	#set PACK arr
	if GlobalData.hellmode == false:
		#hellmode off
		GlobalData._setup_openingpack_arr()
	else:
		#hellmode on
		GlobalData._setup_hellmode_openingpack_arr()
	
	#open PACK animation
	main.card_display.visible = false
	main.animation_player_main.play("openpack")
	
	await main.animation_finished
	#show flip btn
	main.btn_flip.visible = true
	main.btn_flip.disabled = false
	#change GameState to OPENING_BACK
	GlobalStateController.current_state = GlobalStateController.GameState.OPENING_BACK
	#show cardback of 1st card
	main.card_display._update_all()
	
	open_pack_finished.emit()
	####auto flip
	#if Options.auto_flip == true:
		#_flip_card()

##flip
func _on_flip_btn_pressed() -> void:
	_flip_card()
func _flip_card():
	GlobalStateController.current_state = GlobalStateController.GameState.ANIMATION
	#last card
	if main.card_display.cardback_next != null:
		main.card_display.cardback_next.visible = true
	
	main.btn_flip.visible = false
	main.btn_flip.disabled = true
	
	main.card_display._last_card()
	
	main.animation_player_main.play("flip_main")
	
	##count seen
	main._seen_count()
	##icon
	main._seen_n_collected_icon()
	
	##update price on sell btn
	sell_price.text =  "$%.2f" % GlobalData.price_dict.get(main.card_display.card_stat.card_codename)
	
	await main.animation_finished
	
	GlobalStateController.current_state = GlobalStateController.GameState.OPENING_FRONT

##SELL BTN
func _on_sell_btn_pressed() -> void:
	GlobalStateController.current_state = GlobalStateController.GameState.ANIMATION
	
	#collect animation
	main.animation_player_main.play("sell")
	
	#update card displaying
	await main.animation_finished
	
	##sell action
	#GlobalData._action_sell()
	var card = GlobalData.opening_arr.pop_at(0)
	#add to sell_arr
	GlobalData.card_sell_arr.append(card)
	#handle money
	GlobalData.money_added += GlobalData.price_dict.get(card)
	
	
	main.card_display._update_all()
	
	#change to next state
	if GlobalData.opening_arr.size() == 0:
		#state
		GlobalStateController.current_state = GlobalStateController.GameState.STANDBY
		#flip btn
		main.btn_flip.visible = false
		main.btn_flip.disabled = true
		#hide card
		main.card_display.visible = false
	else:
		#state
		GlobalStateController.current_state = GlobalStateController.GameState.OPENING_BACK
		
		main.btn_flip.visible = true
		main.btn_flip.disabled = false
		
		main.card_display.visible = true
		
		####auto flip
		#if Options.auto_flip == true:
			#_flip_card()
	sell_finished.emit()

##KEEP BTN
func _on_keep_btn_pressed() -> void:
	GlobalStateController.current_state = GlobalStateController.GameState.ANIMATION
	
	#collect
	var card = GlobalData.opening_arr.pop_at(0)
	GlobalData.collection_arr.append(card)
	
	#collect animation
	main.animation_player_main.play("keep")
	
	#update card displaying
	await main.animation_finished
	
	main.card_display._update_all()
	
	#change to next state
	if GlobalData.opening_arr.size() == 0:
		#state
		GlobalStateController.current_state = GlobalStateController.GameState.STANDBY
		#flip btn
		main.btn_flip.visible = false
		main.btn_flip.disabled = true
		#hide card
		main.card_display.visible = false
		
	else:
		#state
		GlobalStateController.current_state = GlobalStateController.GameState.OPENING_BACK
		
		main.btn_flip.visible = true
		main.btn_flip.disabled = false
		
		main.card_display.visible = true
		
	keep_finished.emit()
