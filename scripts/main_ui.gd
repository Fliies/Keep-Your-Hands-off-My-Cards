extends CanvasLayer

@onready var money_current:= %MoneyCurrent
@onready var money_added:= %MoneyAdded

@onready var pack_have:= %PackHave

@onready var hint_lbl:= %HintLbl

func _process(_delta: float) -> void:
	_update_money()
	_update_pack_have()
	_hint_lbl_handle()

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

##hint label
func _hint_lbl_handle():
	if GlobalStateController.current_state == GlobalStateController.GameState.OPENING_BACK:
		hint_lbl.label_settings.font_color = Color("WHITE")
		hint_lbl.label_settings.outline_color = Color(1.0,0.52,0.76,1.0)
		hint_lbl.text = "SPACEBAR / CLICK"
		hint_lbl.visible = true
	elif GlobalStateController.current_state == GlobalStateController.GameState.OPENING_FRONT:
		hint_lbl.label_settings.font_color = Color("WHITE")
		hint_lbl.label_settings.outline_color = Color("DIM_GRAY")
		hint_lbl.text = "'A' to SELL                               'D' to KEEP "
		hint_lbl.visible = true
	elif GlobalStateController.current_state == GlobalStateController.GameState.STANDBY:
		hint_lbl.label_settings.font_color = Color("WHITE")
		hint_lbl.label_settings.outline_color = Color("DIM_GRAY")
		hint_lbl.text = "CLICK a PACK to OPEN"
		hint_lbl.visible = true
	else:
		hint_lbl.visible = false
