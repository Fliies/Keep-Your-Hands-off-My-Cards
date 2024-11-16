extends CanvasLayer

@onready var money_current:= %MoneyCurrent
@onready var money_added:= %MoneyAdded

@onready var pack_have:= %PackHave

func _process(_delta: float) -> void:
	_update_money()
	_update_pack_have()

func _update_money():
	##current money
	#amount
	money_current.text = "$%.2f" % GlobalData.money_current
	#color
	if GlobalData.money_current >= 0 :
		money_current.label_settings.font_color = Color("GREEN")
	else:
		money_current.label_settings.font_color = Color("RED")
	
	##added money
	money_added.text = "( + $%.2f )" % GlobalData.money_added
	
	if GlobalData.money_added > 0:
		money_added.visible = true
	else:
		money_added.visible = false
	


func _update_pack_have():
	pack_have.text = str(GlobalData.packcount_box + GlobalData.packcount_single) + " Packs"



func _on_binder_btn_pressed() -> void:
	pass # Replace with function body.
