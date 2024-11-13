extends Node2D

signal animation_finished
signal show_cardback

#@export var STARTING_MONEY: float = 50.0
#@export var STARTING_PACK: int = 10


@onready var action_btn:= %ActionBtn
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

#@onready var icon_seen:= %SeenSprite
@onready var icon_collected:= %CollectedSprite

func _ready() -> void:
	##BTN
	btn_open_pack.visible = false
	btn_keep.visible = false
	btn_sell.visible = false
	btn_flip.visible = false
	
	btn_open_pack.disabled = true
	btn_keep.disabled = true
	btn_sell.disabled = true
	btn_flip.disabled = true
	
	##hand and pack
	pack_sprite.visible = false
	hand_sprite.visible = false
	cardback_hand.visible = false
	$idlecard.visible = false
	
	##card_display
	$CardDisplay/CardBackSprite2.visible = false
	$CardDisplay/CardBackSprite.visible = false
	$CardDisplay/CardSprite.visible = false
	
	##animation
	$Animation/OpenPack.visible = false
	

func _process(_delta: float) -> void:
	
	##debug 
	_debug_process()
	
	##binder btn
	if Input.is_action_just_pressed("binder"):
		
		#close -> open
		if binder_open == false:
			#halt state
			GlobalStateController.prev_state = GlobalStateController.current_state
			GlobalStateController.current_state = GameStateController.GameState.BINDER
			
			#update binder
			binder._update_collection()
			
			binder.visible = true
			binder_open = true
			
		#open -> close
		else:
			binder.visible = false
			binder_open = false
			
			GlobalStateController.current_state = GlobalStateController.prev_state
		
	
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

func _animation_finished():
	#_seen_count()
	#_seen_n_collected_icon()
	animation_finished.emit()

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

func _show_cardback():
	show_cardback.emit()


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
