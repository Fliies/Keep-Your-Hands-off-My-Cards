extends Node2D

signal animation_finished

@onready var sound_hippo_newgame: AudioStreamPlayer = $"HippoIdle-MenuAndIntro"
@onready var sound_hippo_start_game: AudioStreamPlayer = $"HippoStartGame-MenuAndIntro"

@onready var collision_area:= $SpriteExtras05Area/CollisionShape2D

@onready var bg: Sprite2D = $BG

@onready var start_menu_animation: Node2D = $StartMenuAnimation

@onready var hell_mode_continue: TextureRect = $CanvasLayer/MarginContainer/VBoxContainer/HBoxContainer2/HellmodeContinue

@export_category("BUTTON")
@export var container_normal: MarginContainer
@export var newgame_btn: Button
@export var continue_btn: Button
@export var extras_btn: Button
@export var option_btn: Button
@export var back_btn: Button
@export var hell_mode: Button
@export var hell_mode_lbl :Label
#@export var moodeng_extra: Sprite2D
@export var moodeng_extra_area: Area2D

@export_category("Newgame Confirmation")
@export var container_confirmation: MarginContainer
@export var confirm_newgame_btn: Button
@export var comfirm_goback_btn: Button

func _ready() -> void:
	bg.visible = true
	
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
	##music
	SoundManager.music.switch_to_clip_by_name(&"StartMenu")
	
	GlobalStateController.current_state = GlobalStateController.GameState.STARTING_MENU
	
	container_normal.visible = true
	container_confirmation.visible = false
	
	moodeng_extra_area.visible = false
	collision_area.disabled = true
	
	back_btn.visible = false
	GlobalData.hellmode = false
	hell_mode_lbl.visible = false
	hell_mode_continue.visible = false
	
	start_menu_animation._play_idle()
	
	if GlobalData.newgame == true:
		continue_btn.disabled = true
	else:
		continue_btn.disabled = false
		if GlobalData.hellmode_continue == true:
			hell_mode_continue.visible = true


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
	##start sound
	sound_hippo_newgame.stop()
	sound_hippo_start_game.play(0.2)
	
	##hellmode
	GlobalData.hellmode = GlobalData.hellmode_continue
	
	container_normal.visible = false
	container_confirmation.visible = false
	
	GlobalStateController.current_state = GlobalStateController.GameState.ANIMATION
	
	#animation_player.play("start")
	start_menu_animation.animation_player.play("start_game")
	
	await start_menu_animation.animation_finished
	
	ScreenTransition._transition("main")

##newgame
func _on_newgame_btn_pressed() -> void:
	
	if GlobalData.newgame == true:
		_newgame_start()
	else:
		SoundManager._play_ui_click()
		##confirmation
		container_normal.visible = false
		container_confirmation.visible = true

func _newgame_start():
	SoundManager.music.switch_to_clip_by_name(&"Silence")
	
	##start sound
	sound_hippo_newgame.stop()
	sound_hippo_start_game.play(0.2)
	
	##hellmode
	if GlobalData.hellmode == true:
		GlobalData.hellmode_continue = true
	else:
		GlobalData.hellmode_continue = false
	
	container_normal.visible = false
	container_confirmation.visible = false
	
	GlobalStateController.current_state = GlobalStateController.GameState.ANIMATION
	
	#animation_player.play("start")
	start_menu_animation.animation_player.play("start_game")
	
	await start_menu_animation.animation_finished
	
	#temp
	ScreenTransition._transition("op_cutscene")

#NEWGAME CONFIRMATION
func _on_newgame_confirm_btn_pressed() -> void:
	SoundManager._play_ui_click()
	
	GlobalData.newgame = true
	_newgame_start()

func _on_goback_btn_pressed() -> void:
	SoundManager._play_ui_click()
	
	container_normal.visible = true
	container_confirmation.visible = false


func _on_extras_btn_pressed() -> void:
	SoundManager._play_ui_click()
	
	container_normal.visible = false
	container_confirmation.visible = false
	
	moodeng_extra_area.visible = true
	
	#animation_player.play("extras")
	#await animation_finished
	start_menu_animation.animation_player.play("extras_enter")
	start_menu_animation.moodeng_extra.visible = false
	
	await start_menu_animation.animation_finished
	
	collision_area.disabled = false
	back_btn.visible = true


func _on_back_btn_pressed() -> void:
	SoundManager._play_ui_click()
	back_btn.visible = false
	
	collision_area.disabled = true
	
	#animation_player.play("extra_exit")
	
	start_menu_animation.animation_player.play("extras_exit")
	await start_menu_animation.animation_finished
	
	container_normal.visible = true
	container_confirmation.visible = false
	
	moodeng_extra_area.visible = false
	
	#$AnimationSprite/SpriteExtraBg.visible = false
	#$AnimationSprite/SpriteExtras.visible = false
	
	#animation_player.play("idle")
	start_menu_animation._play_idle()


func _on_hell_mode_btn_toggled(toggled_on: bool) -> void:
	SoundManager._play_ui_click_2()
	
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
	#moodeng_extra.visible = true
	start_menu_animation.moodeng_extra.visible = true
	sound_hippo_start_game.play(1.0)
func _on_area_2d_mouse_exited() -> void:
	#moodeng_extra.visible = false
	start_menu_animation.moodeng_extra.visible = false

##OPTIONS
func _on_options_btn_pressed() -> void:
	SoundManager._play_ui_click()
	
	container_normal.visible = false
	
	Options._options_start()

func _on_options_back_pressed():
	SoundManager._play_ui_click()
	
	container_normal.visible = true


##newgame mouse hover
func _on_newgame_btn_mouse_entered() -> void:
	start_menu_animation._play_scream()
	
	sound_hippo_newgame.play(0.25)
	
	#sprite_idle.visible = false
	#sprite_scream.visible = true
	#animation_player.stop()


func _on_newgame_btn_mouse_exited() -> void:
	#sprite_idle.visible = true
	#sprite_scream.visible = false
	
	#animation_player.play("idle")
	start_menu_animation._play_idle()
