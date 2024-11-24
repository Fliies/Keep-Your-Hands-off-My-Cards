extends Node2D

signal finished

@onready var animation_player:= $AnimationPlayer
@onready var next_btn:= $NextBtn

@onready var op_state: int = 0

func _ready() -> void:
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
		ScreenTransition._transition("main")
