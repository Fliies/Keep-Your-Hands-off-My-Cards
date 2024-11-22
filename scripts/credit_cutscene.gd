extends Node2D

signal show_credit
signal animation_finished

@onready var animation_player:= $AnimationPlayer

func _show_credit():
	show_credit.emit()

func _animation_finished():
	animation_finished.emit()

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
