extends Node2D

@onready var shop_menu:= %ShopMenu
@onready var shop_cardlist:= %ShopCardlist

func _ready() -> void:
	#self.visible = false
	
	shop_menu.visible = true
	shop_cardlist.visible = false
	
	_slot_cardlist("aa",%aaSprite,%aaPrice,%aaAmount)
	_slot_cardlist("bb",%bbSprite,%bbPrice,%bbAmount)
	_slot_cardlist("ww",%wwSprite,%wwPrice,%wwAmount)
	_slot_cardlist("xx",%xxSprite,%xxPrice,%xxAmount)


func _on_shop_cardlist_btn_pressed() -> void:
	#visiblility
	shop_menu.visible = false
	shop_cardlist.visible = true

func _on_back_btn_pressed() -> void:
	#visiblility
	shop_menu.visible = true
	shop_cardlist.visible = false

func _slot_cardlist(codename:String, node_sprite:TextureRect, node_price:Label, node_amount:Label):
	##texture
	node_sprite.texture = load("res://Cards/CardSprite/%s.png" % codename)
	
	###price
	node_price.text = "$"+str(GlobalData.price_dict[codename])
	
	##amount copy
	node_amount.text = "x" + str(GlobalData.collection_arr.count(codename))
	
	##available?
	# cu 90%
	if GlobalData.common_arr.has(codename) or GlobalData.uncommon_arr.has(codename):
		var rng = randi_range(1,10)
		if rng == 1:
			#out of stock
			pass
		else:
			#add to shop_arr
			GlobalData.shop_arr.append(codename)
	# rare 75%
	elif GlobalData.rare_arr.has(codename):
		var rng = randi_range(1,4)
		if rng == 1:
			#out of stock
			pass
		else:
			GlobalData.shop_arr.append(codename)
	
	#temp visible
	if GlobalData.shop_arr.has(codename):
		pass
	else:
		node_sprite.visible = false
