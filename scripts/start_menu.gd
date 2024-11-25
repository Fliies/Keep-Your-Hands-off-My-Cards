extends Node2D

signal animation_finished

@onready var BG:= $BG
@onready var animation_player:= $AnimationPlayer
@onready var sprite_idle:= $AnimationPlayer/Sprite
@onready var sprite_scream:= $AnimationPlayer/SpriteScream
@onready var collision_area:= $AnimationPlayer/SpriteExtras05Area/CollisionShape2D

@export_category("BUTTON")
@export var container_normal: MarginContainer
@export var newgame_btn: Button
@export var continue_btn: Button
@export var extras_btn: Button
@export var option_btn: Button
@export var back_btn: Button
@export var hell_mode: Button
@export var hell_mode_lbl :Label
@export var moodeng_extra: Sprite2D
@export var moodeng_extra_area: Area2D

@export_category("Newgame Confirmation")
@export var container_confirmation: MarginContainer
@export var confirm_newgame_btn: Button
@export var comfirm_goback_btn: Button

func _ready() -> void:
	Options.connect("options_back", _on_options_back_pressed)
	
	container_normal.visible = false
	container_confirmation.visible = false
	back_btn.visible = false
	
	if GlobalStateController.current_state == GlobalStateController.GameState.ANIMATION:
		await ScreenTransition.animation_finished
		_startmenu_setup()
	else:
		_startmenu_setup()

func _startmenu_setup():
	GlobalStateController.current_state = GlobalStateController.GameState.STARTING_MENU
	
	container_normal.visible = true
	container_confirmation.visible = false
	
	moodeng_extra.visible = false
	moodeng_extra_area.visible = false
	collision_area.disabled = true
	
	back_btn.visible = false
	hell_mode_lbl.visible = false
	
	animation_player.play("idle")
	
	
	if GlobalData.newgame == true:
		continue_btn.disabled = true
	else:
		continue_btn.disabled = false
	
	if GlobalData.hellmode == true:
		hell_mode_lbl.visible = true
	else: 
		hell_mode_lbl.visible = false


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
	print(GlobalData.hellmode)
	#if GlobalData.newgame == true:
		#GlobalData.newgame = false
	#else:
		#GlobalData.newgame = true

##CONTINUE
func _on_continue_btn_pressed() -> void:
	
	container_normal.visible = false
	container_confirmation.visible = false
	
	GlobalStateController.current_state = GlobalStateController.GameState.ANIMATION
	
	animation_player.play("start")
	
	await animation_finished
	
	ScreenTransition._transition("main")

##newgame
func _on_newgame_btn_pressed() -> void:
	if GlobalData.newgame == true:
		_newgame_start()
	else:
		##confirmation
		container_normal.visible = false
		container_confirmation.visible = true

func _newgame_start():
	container_normal.visible = false
	container_confirmation.visible = false
	
	GlobalStateController.current_state = GlobalStateController.GameState.ANIMATION
	
	animation_player.play("start")
	
	await animation_finished
	
	#temp
	ScreenTransition._transition("op_cutscene")

#NEWGAME CONFIRMATION
func _on_newgame_confirm_btn_pressed() -> void:
	GlobalData.newgame = true
	_newgame_start()

func _on_goback_btn_pressed() -> void:
	container_normal.visible = true
	container_confirmation.visible = false


func _on_extras_btn_pressed() -> void:
	container_normal.visible = false
	container_confirmation.visible = false
	
	moodeng_extra_area.visible = true
	
	animation_player.play("extras")
	await animation_finished
	collision_area.disabled = false
	back_btn.visible = true


func _on_back_btn_pressed() -> void:
	collision_area.disabled = true
	
	animation_player.play("extra_exit")
	
	await animation_finished
	
	container_normal.visible = true
	container_confirmation.visible = false
	
	moodeng_extra_area.visible = false
	
	$AnimationPlayer/SpriteExtraBg.visible = false
	$AnimationPlayer/SpriteExtras.visible = false
	back_btn.visible = false
	
	animation_player.play("idle")


func _on_hell_mode_btn_toggled(toggled_on: bool) -> void:
	if toggled_on == true:
		GlobalData.hellmode = true
	else:
		GlobalData.hellmode = false

func _on_hell_mode_btn_mouse_entered() -> void:
	hell_mode_lbl.visible = true

func _on_hell_mode_btn_mouse_exited() -> void:
	#if GlobalData.hellmode == false:
	hell_mode_lbl.visible = false


##moo deng
func _on_area_2d_mouse_entered() -> void:
	moodeng_extra.visible = true
	
func _on_area_2d_mouse_exited() -> void:
	moodeng_extra.visible = false

##OPTIONS
func _on_options_btn_pressed() -> void:
	
	container_normal.visible = false
	
	Options._options_start()

func _on_options_back_pressed():
	
	container_normal.visible = true
