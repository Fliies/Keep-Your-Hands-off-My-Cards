extends Resource

class_name CardStats

enum RARITY {COMMON, UNCOMMON, RARE, SECRET, EXTRA}

@export var card_sprite: Texture2D
@export var card_back: Texture2D
@export var card_name: String = "card_name"
@export var card_codename: String = "NN"
@export var card_rarity: String = "COMMON"


@export var card_rarity_enum: RARITY = RARITY.COMMON
@export var card_seen: bool = false
@export var card_collected: bool = false
@export var card_copy: int = 0
@export var card_price: float


#enum PRICE_RANGE {PRICE_COMMON, PRICE_UNCOMMON, PRICE_RARE, PRICE_SECRET}
#@export var card_price_range: PRICE_RANGE

#@export_category("PRICE RANGE")
#@export var PRICE_COMMON:Array[float] = [1.0, 1.5, 2.0, 2.5, 3.0 ]
#@export var PRICE_UNCOMMON:Array[float] = [6.5, 7.0, 7.5, 8.0, 8.5, 9.0, 9.5]
#@export var PRICE_RARE:Array[float] = [45.0, 50.0, 60.0]
#@export var PRICE_SECRET:Array[float] = [500.0]
#
#func _set_card_price():
	#match RARITY:
		#RARITY.COMMON:
			#card_price = PRICE_COMMON.pick_random()
		#RARITY.UNCOMMON:
			#card_price = PRICE_UNCOMMON.pick_random()
		#RARITY.RARE:
			#card_price = PRICE_RARE.pick_random()
		#RARITY.SECRET:
			#card_price = PRICE_SECRET.pick_random()
	#
