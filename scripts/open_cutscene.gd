extends Node2D

signal finished

@export var box_close: Texture2D
@export var box_open: Texture2D
@export var open_card: Sprite2D

@onready var animation_player:= $AnimationPlayer
@onready var next_btn:= $NextBtn

@onready var cutscene_sprite:= $OPcutsceneSprite
@onready var box_open_sprite:= $OPBoxOpen
@onready var box_open_lbl:= $Label
@onready var start_btn= $Button

@onready var op_state: int = 0

func _ready() -> void:
	box_open_sprite.visible = false
	box_open_lbl.visible = false
	start_btn.disabled = true
	open_card.visible = false
	
	next_btn.visible = false
	next_btn.disabled = true
	
	await ScreenTransition.animation_finished
	
	animation_player.play("op_01")
	
	await finished
	
	op_state = 1

func _finished():
	finished.emit()

func _disable_next_btn():
	next_btn.visible = false
	next_btn.disabled = true

func _eneble_next_btn():
	next_btn.visible = true
	next_btn.disabled = false

func _on_next_btn_pressed() -> void:
	if op_state == 1:
		animation_player.play("op_02")
		
		await finished
		
		animation_player.play("op_03")
		
		await finished
		
		op_state = 3
		
	elif op_state == 3:
		next_btn.disabled = true
		
		animation_player.play("op_04")
		await finished
		
		#cutscene_sprite.set_frame(2)
		#box_open_sprite.texture = box_close
		#box_open_sprite.visible = true
		box_open_lbl.visible = true
		start_btn.disabled = false

func _chang_bg():
	cutscene_sprite.set_frame(2)
	#box_open_sprite.visible = true
	box_open_sprite.texture = box_close


func _on_button_pressed() -> void:
	ScreenTransition._transition("main")

func _on_button_mouse_entered() -> void:
	if op_state == 3:
		box_open_sprite.texture = box_open

func _on_button_mouse_exited() -> void:
	box_open_sprite.texture = box_close
