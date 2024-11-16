extends Node2D

@onready var BG:= $BG
@onready var animation_player:= $AnimationPlayer

func _ready() -> void:
	animation_player.play("idle")
	#$AnimationPlayer/SpriteScream.visible = false

#func _process(_delta: float) -> void:

func _on_button_pressed() -> void:
	#$AnimationPlayer/SpriteScream.visible = true
	animation_player.play("start")
