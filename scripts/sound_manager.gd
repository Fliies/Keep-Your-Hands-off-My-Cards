extends Node

signal sound_finished

@onready var music_bg: AudioStreamPlayer = $Music/music_bg

@onready var ui_click: AudioStreamPlayer = $SFX/UiClick
@onready var ui_click_new: AudioStreamPlayer = $"SFX/UiClick-new-General"
@onready var ui_click_2: AudioStreamPlayer = $SFX/UIClick2

@onready var card_flip: AudioStreamPlayer = $SFX/CardFlip
@onready var card_pack_idle: AudioStreamPlayer = $SFX/CardPackIdle
@onready var card_sell: AudioStreamPlayer = $SFX/CardSell
@onready var card_collect: AudioStreamPlayer = $SFX/CardCollect
@onready var open_package: AudioStreamPlayer = $SFX/OpenPackage
@onready var credit_card_acquired: AudioStreamPlayer = $"SFX/CreditCardAcquired-Special"
@onready var license_acquired: AudioStreamPlayer = $"SFX/LicenseAcquired-Special"
@onready var open_box: AudioStreamPlayer = $SFX/Openbox
@onready var binder: AudioStreamPlayer = $"SFX/BinderEnter-General"
@onready var binder_page_flip: AudioStreamPlayer = $SFX/BinderPageFlip
@onready var motorcycle_back_home: AudioStreamPlayer = $SFX/MotorcycleBackHome
@onready var motorcycle_to_shop: AudioStreamPlayer = $SFX/MotorcycleToShop
@onready var handle_money: AudioStreamPlayer = $SFX/HandleMoney

@onready var shop_cardlist_hover: AudioStreamPlayer = $SFX/shopCardlistHover
@onready var shop_cardpack_hover: AudioStreamPlayer = $SFX/shopCardpackHover
@onready var shop_box_hover: AudioStreamPlayer = $SFX/ShopBoxHover
@onready var shop_offer_sfx: AudioStreamPlayer = $SFX/ShopOfferSFX


func _ready() -> void:
	music_bg.play()
	
	#set to sfx bus
	var all_audio = $SFX.get_children()
	for audio in all_audio:
		audio.bus = "SFX"

func _play_ui_click():
	
	#ui_click.play(0.013)
	ui_click_new.play(0.01)

func _play_ui_click_2():
	
	ui_click_2.pitch_scale = randf_range(0.8,1.2)
	ui_click_2.play(0.11)

func _play_sfx_random_pitch(sfx_sound:AudioStreamPlayer, from_position:float):
	
	sfx_sound.pitch_scale = randf_range(0.7,1.3)
	
	sfx_sound.play(from_position)

func _play_sfx(sfx_sound:AudioStreamPlayer, from_position:float):
	
	sfx_sound.play(from_position)

func _play_binder_flip(page:String):
	if page == "RIGHT":
		binder_page_flip.pitch_scale += 0.2
		binder_page_flip.play()
	else:
		binder_page_flip.pitch_scale -= 0.2
		binder_page_flip.play()
	

func _acquired_card():
	credit_card_acquired.play(0.2)
	
	sound_finished.emit()

func _play_buycard():
	
	card_flip.pitch_scale = randf_range(0.7,1.3)
	
	card_flip.play(0.1)

func _play_handle_money():
	
	handle_money.pitch_scale = randf_range(0.7,1.3)
	
	handle_money.play()

func _shop_offer_sfx():
	
	shop_offer_sfx.pitch_scale = randf_range(1.5,2.0)
	
	shop_offer_sfx.play(0.03)

func _pause_music():
	music_bg.stream_paused = true

func _resume_music():
	music_bg.stream_paused = false

##DEBUG
func _on_test_1_pressed() -> void:
	_play_ui_click()

func _on_test_2_pressed() -> void:
	_play_ui_click_2()
