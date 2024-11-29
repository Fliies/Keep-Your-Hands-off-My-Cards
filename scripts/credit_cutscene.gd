extends Node2D

signal show_credit
signal animation_finished

@onready var animation_player:= $AnimationPlayer

@onready var _01_phone_call: AudioStreamPlayer = $"01-phoneCall"
@onready var _02_pickup: AudioStreamPlayer = $"02-pickup"
@onready var _03_message_mom: AudioStreamPlayer = $"03-messageMom"
@onready var _04_message_you: AudioStreamPlayer = $"04-messageYou"
@onready var _05_mom_angry: AudioStreamPlayer = $"05-momAngry"
@onready var _06_credit_card_acquired: AudioStreamPlayer = $"06-creditCardAcquired"

func _play_phonecall():
	_01_phone_call.play()
func _play_pickup():
	_02_pickup.play()
func _play_mom_msg():
	_03_message_mom.play()
func _play_son_msg():
	_04_message_you.play()
func _play_angry():
	_05_mom_angry.play()
func _play_credit():
	_06_credit_card_acquired.play()


func _show_credit():
	show_credit.emit()

func _animation_finished():
	animation_finished.emit()

func _pause_music():
	SoundManager._pause_music()

func _resume_music():
	SoundManager._resume_music()

#func _ready() -> void:
	#$Binder.visible = true
	#animation_player.play("callmom_1")
	#await animation_finished
	#animation_player.play("callmom_2")
	#await animation_finished
	#animation_player.play("callmom_3")
	#await animation_finished
	#animation_player.play("callmom_4")
	#await animation_finished
