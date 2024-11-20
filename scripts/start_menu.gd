extends Node2D

signal animation_finished

@onready var BG:= $BG
@onready var animation_player:= $AnimationPlayer

@export_category("BUTTON")
@export var newgame_btn: Button
@export var continue_btn: Button
@export var extras_btn: Button
@export var option_btn: Button
@export var back_btn: Button


func _ready() -> void:
	
	back_btn.visible = false
	
	GlobalStateController.current_state = GlobalStateController.GameState.STARTING_MENU
	animation_player.play("idle")

func _process(_delta: float) -> void:
	if GlobalData.newgame == true:
		continue_btn.disabled = true
	else:
		continue_btn.disabled = false

##signal
func _animation_finished():
	animation_finished.emit()

##debug
func _on_newgame_pressed() -> void:
	if GlobalData.newgame == true:
		GlobalData.newgame = false
	else:
		GlobalData.newgame = true

#newgame
func _on_newgame_btn_pressed() -> void:
	newgame_btn.visible = false
	continue_btn.visible = false
	extras_btn.visible = false
	option_btn.visible = false
	
	GlobalStateController.current_state = GlobalStateController.GameState.ANIMATION
	animation_player.play("start")
	
	await animation_finished
	ScreenTransition._transition("main")


func _on_extras_btn_pressed() -> void:
	newgame_btn.visible = false
	continue_btn.visible = false
	extras_btn.visible = false
	option_btn.visible = false
	
	animation_player.play("extras")
	await animation_finished
	back_btn.visible = true


func _on_back_btn_pressed() -> void:
	animation_player.play("extra_exit")
	
	await animation_finished
	newgame_btn.visible = true
	continue_btn.visible = true
	extras_btn.visible = true
	option_btn.visible = true
	
	$AnimationPlayer/SpriteExtraBg.visible = false
	$AnimationPlayer/SpriteExtras.visible = false
	back_btn.visible = false
