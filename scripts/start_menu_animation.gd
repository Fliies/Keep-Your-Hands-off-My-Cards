extends Node2D

signal animation_finished

@onready var animation_player: AnimationPlayer = $AnimationPlayer

@onready var idle_sprite: Sprite2D = $IdleSprite
@onready var scream_sprite: Sprite2D = $ScreamSprite

@onready var extras: Node2D = $Extras
@onready var moodeng_extra: Sprite2D = $Extras/MoodengExtra

func _ready() -> void:
	self.visible = true
	extras.visible = false
	scream_sprite.visible = false
	idle_sprite.visible = true
	moodeng_extra.visible = false

func _animation_finished():
	animation_finished.emit()

func _play_idle():
	idle_sprite.visible = true
	scream_sprite.visible = false
	animation_player.play("idle_new")

func _play_scream():
	animation_player.stop()
	scream_sprite.visible = true
	idle_sprite.visible = false
