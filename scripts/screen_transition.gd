extends Node

@onready var animation_player:= $AnimationPlayer

@export var main_scene: PackedScene
@export var shop_scene: PackedScene
@export var startmenu_scene: PackedScene

@export var temp_sprite: Sprite2D
@export var temp_shop_sprite: Texture2D
@export var temp_main_sprite: Texture2D

signal new_scene
signal animation_finished

func _transition(scene:String):
	match scene:
		"main":
			if GlobalData.newgame == true:
				##opneing cutscene
				
				##temp
				animation_player.play("START_transition")
				
				await  new_scene
				get_tree().change_scene_to_packed(main_scene)
				
				await animation_finished
				GlobalStateController.current_state = GlobalStateController.GameState.STANDBY
				
			else:
				animation_player.play("START_transition")
				
				await  new_scene
				get_tree().change_scene_to_packed(main_scene)
				
				await animation_finished
				GlobalStateController.current_state = GlobalStateController.GameState.STANDBY
		"startmenu":
			get_tree().change_scene_to_packed(startmenu_scene)

##signal
func _new_scene():
	new_scene.emit()
func _animation_finished():
	animation_finished.emit()

#change temp
func _shop_sprite():
	temp_sprite.texture = temp_shop_sprite
func _main_sprite():
	temp_sprite.texture = temp_main_sprite

##DEBUG
func _on_button_pressed() -> void:
	animation_player.play("toShop_transition")
func _on_button_2_pressed() -> void:
	animation_player.play("BackFromShop_transition")
func _on_button_3_pressed() -> void:
	animation_player.play("START_transition")
