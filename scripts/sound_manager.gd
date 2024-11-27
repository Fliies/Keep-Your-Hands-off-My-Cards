extends Node

@onready var ui_click: AudioStreamPlayer = $SFX/UiClick
@onready var card_flip: AudioStreamPlayer = $SFX/CardFlip
@onready var card_pack_idle: AudioStreamPlayer = $SFX/CardPackIdle
@onready var card_sell: AudioStreamPlayer = $SFX/CardSell
@onready var card_collect: AudioStreamPlayer = $SFX/CardCollect
@onready var open_package: AudioStreamPlayer = $SFX/OpenPackage
@onready var credit_card_acquired: AudioStreamPlayer = $"SFX/CreditCardAcquired-Special"
@onready var license_acquired: AudioStreamPlayer = $"SFX/LicenseAcquired-Special"
@onready var open_box: AudioStreamPlayer = $SFX/Openbox
@onready var binder: AudioStreamPlayer = $"SFX/BinderEnter-General"
@onready var birthday_card_flip: AudioStreamPlayer = $"SFX/BirthdayCardFlip-MenuAndIntro"
@onready var motorcycle_back_home: AudioStreamPlayer = $SFX/MotorcycleBackHome
@onready var motorcycle_to_shop: AudioStreamPlayer = $SFX/MotorcycleToShop


func _play_ui_click():
	
	#ui_click.play(0.012)
	
	#card_pack_idle.volume_db = 20
	card_pack_idle.pitch_scale = randf_range(0.8,1.2)
	card_pack_idle.play(0.11)

func _play_sfx_random_pitch(sfx_sound:AudioStreamPlayer, from_position:float):
	
	sfx_sound.pitch_scale = randf_range(0.7,1.3)
	
	sfx_sound.play(from_position)

func _play_sfx(sfx_sound:AudioStreamPlayer, from_position:float):
	
	sfx_sound.play(from_position)
