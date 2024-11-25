extends CanvasLayer

#@onready var text_shader:= load("res://scripts/shop.gdshader")
@onready var money_current:= %MoneyCurrent
@onready var money_added:= %MoneyAdded

@onready var hellmode_icon:= $UI/UpperUiMargin/UpperUIVbox/HBoxRight/HellmodeIcon/HellmodeSprite

@onready var pack_have:= %PackHave

@onready var hint_lbl:= %HintLbl

func _process(_delta: float) -> void:
	
	_update_money()
	_update_pack_have()
	_hint_lbl_handle()
	
	##hellmode icon
	if GlobalData.hellmode == true:
		hellmode_icon.visible = true
	else:
		hellmode_icon.visible = false

func _update_money():
	##current money
	#amount
	if GlobalData.debt == false:
		money_current.text = "$%.2f" % GlobalData.money_current
		if GlobalData.money_current >= 0 :
			money_current.label_settings.font_color = Color(0.584, 0.824, 0.063)
		else:
			money_current.label_settings.font_color = Color("RED")
	else:
		money_current.label_settings.font_color = Color("RED")
		money_current.text = "Mommy "
	#color
	
	##added money
	if GlobalData.debt == false:
		if GlobalData.money_added > 0:
			money_added.visible = true
			money_added.label_settings.font_color = Color.BLACK
			money_added.horizontal_alignment = HORIZONTAL_ALIGNMENT_RIGHT
			money_added.text = "( + $%.2f )" % GlobalData.money_added
		else:
			money_added.visible = false
	else:
		money_added.visible = true
		money_added.label_settings.font_color = Color.RED
		money_added.horizontal_alignment = HORIZONTAL_ALIGNMENT_CENTER
		money_added.text = "got this"


func _update_pack_have():
	#pack_have.text = str(GlobalData.packcount_box + GlobalData.packcount_single) + " Packs"
	pack_have.text = "x%s" % (GlobalData.packcount_box + GlobalData.packcount_single)
	
	if (GlobalData.packcount_box + GlobalData.packcount_single) <= 1:
		pack_have.label_settings.font_color = Color.RED
	else:
		pack_have.label_settings.font_color = Color(0, 0.235, 1)
	
	#if GlobalData.debt == true:
		#pack_have.text = "x %s" % min((GlobalData.packcount_box + GlobalData.packcount_single),99)
	if (GlobalData.packcount_box + GlobalData.packcount_single) > 99:
		pack_have.text = "x99+"
	

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
		hint_lbl.visible = false
		hint_lbl.label_settings.font_color = Color("WHITE")
		hint_lbl.label_settings.outline_color = Color("DIM_GRAY")
		hint_lbl.text = "CLICK a PACK to OPEN"
		if GlobalData.packcount_box == 0 and GlobalData.packcount_single == 0:
			hint_lbl.label_settings.font_color = Color("WHITE")
			hint_lbl.label_settings.outline_color = Color("DIM_GRAY")
			hint_lbl.text = "YOU HAVE NO PACK TO OPEN"
			hint_lbl.visible = true
	else:
		hint_lbl.visible = false
	
