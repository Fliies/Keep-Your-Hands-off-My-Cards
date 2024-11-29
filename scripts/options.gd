extends Control

signal options_back


@export var back_btn: Button
@export var back_to_start_btn: Button
@export var exit_btn: Button

@export var checkbox_empty: Texture2D
@export var checkbox_fill: Texture2D

@export var auto_flip_btn: Button

@export var auto_flip:bool = false
@onready var shop_bg:= $ShopBG

func _ready() -> void:
	shop_bg.visible = false
	
	self.visible = false

func _process(_delta: float) -> void:
	
	pass


func _options_start():
	GlobalStateController.current_state = GlobalStateController.GameState.OPTIONS_START
	
	self.visible = true
	
	back_btn.disabled = false
	back_to_start_btn.disabled = true
	exit_btn.disabled = false

func _options_main():
	GlobalStateController.prev_state = GlobalStateController.current_state
	GlobalStateController.current_state = GlobalStateController.GameState.OPTIONS_MAIN
	
	##shop
	if GlobalStateController.prev_state != GlobalStateController.GameState.STANDBY:
		shop_bg.visible = true
	else:
		shop_bg.visible = false
	
	self.visible = true


func _on_back_btn_pressed() -> void:
	SoundManager._play_ui_click()
	
	##start menu
	if GlobalStateController.current_state == GlobalStateController.GameState.OPTIONS_START:
		GlobalStateController.current_state = GlobalStateController.GameState.STARTING_MENU
		
		self.visible = false
		
		options_back.emit()
	##main scene
	elif GlobalStateController.current_state == GlobalStateController.GameState.OPTIONS_MAIN:
		
		#shop
		if GlobalStateController.prev_state != GlobalStateController.GameState.STANDBY:
			shop_bg.visible = false
		
		GlobalStateController.current_state = GlobalStateController.prev_state
		
		self.visible = false
		
		options_back.emit()


func _on_exit_btn_pressed() -> void:
	SoundManager._play_ui_click_2()
	if GlobalStateController.current_state == GlobalStateController.GameState.OPTIONS_START:
		get_tree().quit()
	elif GlobalStateController.current_state == GlobalStateController.GameState.OPTIONS_MAIN:
		self.visible = false
		ScreenTransition._transition("startmenu")
		
		pass


func _on_autoflip_btn_toggled(toggled_on: bool) -> void:
	SoundManager._play_ui_click_2()
	
	if toggled_on == true:
		auto_flip = true
	else:
		auto_flip = false
