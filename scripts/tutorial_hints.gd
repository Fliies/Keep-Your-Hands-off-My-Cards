extends Node2D

signal tutorial_finished

func _ready() -> void:
	self.visible = false

func _tutorial():
	if GlobalData.newgame == true:
		
		self.visible = true
	else:
		#self.visible = false
		
		tutorial_finished.emit()


func _on_gotit_btn_pressed() -> void:
	self.visible = false
	
	GlobalData.newgame = false
	
	tutorial_finished.emit()
