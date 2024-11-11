extends Node

												#ideal #garuntee 5 box, 50 packs, 250 card
# 14 common		a b c d e f g h i j k l m n		70%		60%		149+mp
# 8 uncommon	o p q r s t u v					20%		33.6%	84
# 3 rare		w x y							9%		6%		15
# 1 secret		z								1%		0.4% 	1
# 1 misprint	mp												*1

# 5 box = 250 cards

## 1st 5 pack -> 25

@export_category("PRICE RANGE")
@export var PRICE_COMMON:Array[float] = [1.0, 1.5, 2.0, 2.5, 3.0 ]
@export var PRICE_UNCOMMON:Array[float] = [6.5, 7.0, 7.5, 8.0, 8.5, 9.0, 9.5]
@export var PRICE_RARE:Array[float] = [45.0, 50.0, 60.0]
@export var PRICE_SECRET:Array[float] = [500.0]
@export var PRICE_EXRTA:Array[float] = [80.0, 100.0, 120.0]


@onready var common_arr:= [
	"aa","aa","aa","aa","aa","aa","aa","aa","aa","aa",
	"bb","bb","bb","bb","bb","bb","bb","bb","bb","bb",
	"cc","cc","cc","cc","cc","cc","cc","cc","cc","cc",
	"dd","dd","dd","dd","dd","dd","dd","dd","dd","dd",
	"ee","ee","ee","ee","ee","ee","ee","ee","ee","ee",
	"ff","ff","ff","ff","ff","ff","ff","ff","ff","ff","ff",
	"gg","gg","gg","gg","gg","gg","gg","gg","gg","gg","gg",
	"hh","hh","hh","hh","hh","hh","hh","hh","hh","hh","hh",
	"ii","ii","ii","ii","ii","ii","ii","ii","ii","ii","ii",
	"jj","jj","jj","jj","jj","jj","jj","jj","jj","jj","jj",
	"kk","kk","kk","kk","kk","kk","kk","kk","kk","kk","kk",
	"ll","ll","ll","ll","ll","ll","ll","ll","ll","ll","ll",
	"mm","mm","mm","mm","mm","mm","mm","mm","mm","mm","mm",
	"nn","nn","nn","nn","nn","nn","nn","nn","nn","nn","nn",
]

@onready var uncommon_arr:= [
	"oo","oo","oo","oo","oo","oo","oo","oo","oo","oo",
	"pp","pp","pp","pp","pp","pp","pp","pp","pp","pp",
	"qq","qq","qq","qq","qq","qq","qq","qq","qq","qq",
	"rr","rr","rr","rr","rr","rr","rr","rr","rr","rr",
	"ss","ss","ss","ss","ss","ss","ss","ss","ss","ss","ss",
	"tt","tt","tt","tt","tt","tt","tt","tt","tt","tt","tt",
	"uu","uu","uu","uu","uu","uu","uu","uu","uu","uu","uu",
	"vv","vv","vv","vv","vv","vv","vv","vv","vv","vv","vv",
]

@onready var rare_arr:= [
	"ww","ww","ww","ww","ww",
	"xx","xx","xx","xx","xx",
	"yy","yy","yy","yy","yy",
]

@onready var secret_arr:= ["zz"]

@onready var misprint_arr:= ["ex_misprint"]
@onready var promo_arr:= ["ex_promo"]
@onready var driver_arr:= ["ex_driver"]
@onready var credit_arr:= ["ex_credit"]
@onready var completed_arr:= [ 
	"aa", "bb", "cc", "dd", "ee", "ff", "gg", "hh", "ii" ,"jj", "kk", "ll", "mm",
	"nn", "oo", "pp", "qq", "rr", "ss", "tt", "uu", "vv", "ww", "xx", "yy", "zz",
	"ex_promo", "ex_misprint", "ex_driver", "ex_credit"
	]

@onready var box_cu_arr:= []
@onready var box_rs_arr:= []
@onready var single_cu_arr:= []
@onready var single_rs_arr:= []

@onready var packcount_box: int = 0
@onready var packcount_single: int = 0
@onready var total_open_packcount: int = 0

@onready var opening_arr:= []

@onready var collection_arr:= []
@onready var seen_arr:= []
@onready var money_current: float = 50.0
@onready var money_added: float = 0.0

@onready var price_dict: Dictionary = {}

func _ready() -> void:
	_update_price()

func _process(_delta: float) -> void:
	###loot list check
	#if box_cu_arr.size() == 0 and box_rs_arr.size() == 0:
		#_setup_droplist_arr(box_cu_arr, box_rs_arr)
	#
	#if single_cu_arr.size() == 0 and single_rs_arr.size() == 0:
		#_setup_droplist_arr(single_cu_arr, single_rs_arr)
	pass


func _setup_droplist_arr(a_arr:Array, b_arr:Array):
	a_arr.append_array(misprint_arr)
	a_arr.append_array(common_arr)
	a_arr.append_array(uncommon_arr)
	a_arr.shuffle()
	
	b_arr.append_array(rare_arr)
	b_arr.append_array(secret_arr)
	b_arr.shuffle()


func _setup_cardpack_arr(cu_arr:Array, rs_arr:Array ):
## card 1, 2, 3
	#normal case (cu, cu, cu)
	if cu_arr.size() >= 3:
		opening_arr.append(cu_arr.pop_front())
		opening_arr.append(cu_arr.pop_front())
		opening_arr.append(cu_arr.pop_front())
	#rare case 1 (cu, cu, rs)
	elif cu_arr.size() == 2:
		opening_arr.append(cu_arr.pop_front())
		opening_arr.append(cu_arr.pop_front())
		opening_arr.append(rs_arr.pop_front())
	#rare case 2 (cu, rs, rs)
	elif cu_arr.size() == 1: 
		opening_arr.append(cu_arr.pop_front())
		opening_arr.append(rs_arr.pop_front())
		opening_arr.append(rs_arr.pop_front())
	#rare case 3 (rs, rs, rs)
	elif cu_arr.size() == 0:
		opening_arr.append(rs_arr.pop_front())
		opening_arr.append(rs_arr.pop_front())
		opening_arr.append(rs_arr.pop_front())
	
	#fail safe 1, 2, 3
	if opening_arr.size() < 3:
		while opening_arr.size() < 3:
			opening_arr.append("oo")
	
	
## card 4, 5
	var rng:= randi_range(1,10)
	# (cu, cu) 1, 2, 3 
	if rng <= 7:
		#normal case (cu, cu)
		if cu_arr.size() >= 2:
			opening_arr.append(cu_arr.pop_front())
			opening_arr.append(cu_arr.pop_front())
		#rare case 1 (cu, rs) 
		elif cu_arr.size() == 1:
			opening_arr.append(cu_arr.pop_front())
			opening_arr.append(rs_arr.pop_front())
		#rare case 2 (rs, rs)
		elif cu_arr.size() == 0:
			opening_arr.append(rs_arr.pop_front())
			opening_arr.append(rs_arr.pop_front()) 
	
	# (cu, rs) 4
	elif rng == 8 or rng == 9:
		#normal case (cu, rs)
		if cu_arr.size() >= 1 and rs_arr.size() >= 1:
			opening_arr.append(cu_arr.pop_front())
			opening_arr.append(rs_arr.pop_front())
		#rare case 1 (cu, cu)
		elif rs_arr.size() == 0:
			opening_arr.append(cu_arr.pop_front())
			opening_arr.append(cu_arr.pop_front())
		#rare case 2 (rs,rs)
		elif cu_arr.size() == 0:
			opening_arr.append(rs_arr.pop_front())
			opening_arr.append(rs_arr.pop_front())
	
	# (rs, rs) 5
	elif rng == 10:
		#normal case (rs, rs)
		if rs_arr.size() >= 2:
			opening_arr.append(rs_arr.pop_front())
			opening_arr.append(rs_arr.pop_front())
		#rare case 1 (cu, rs)
		elif rs_arr.size() == 1:
			opening_arr.append(cu_arr.pop_front())
			opening_arr.append(rs_arr.pop_front())
		#rare case 2 (cu, cu)
		elif rs_arr.size() == 0:
			opening_arr.append(cu_arr.pop_front())
			opening_arr.append(cu_arr.pop_front())
	
	#fail safe 4, 5
	if opening_arr.size() < 5:
		while opening_arr.size() < 5:
			opening_arr.append("ss")

func _setup_openingpack_arr():
	##loot list check
	if box_cu_arr.size() == 0 and box_rs_arr.size() == 0:
		_setup_droplist_arr(box_cu_arr, box_rs_arr)
	
	if single_cu_arr.size() == 0 and single_rs_arr.size() == 0:
		_setup_droplist_arr(single_cu_arr, single_rs_arr)
	
	#use Box_arr before SINGLE_arr
	#if packcount_box > 0:
		#packcount_box -= 1
		#_setup_cardpack_arr(box_cu_arr, box_rs_arr)
	#
	#elif packcount_box == 0:
		#packcount_single -= 1
		#_setup_cardpack_arr(single_cu_arr, single_rs_arr)
		#
	
	#use SINGLE_arr before Box_arr
	if packcount_single > 0:
		packcount_single -= 1
		_setup_cardpack_arr(single_cu_arr, single_rs_arr)
	
	elif packcount_single == 0 and packcount_box > 0:
		packcount_box -= 1
		_setup_cardpack_arr(box_cu_arr, box_rs_arr)


func _action_sell():
	var card = opening_arr.pop_at(0)
	#handle money
	money_added += price_dict.get(card)

func _action_collect():
	var card = opening_arr.pop_at(0)
	collection_arr.append(card)

func _update_price():
	price_dict.clear()
	
	price_dict.aa = PRICE_COMMON.pick_random()
	price_dict.bb = PRICE_COMMON.pick_random()
	price_dict.cc = PRICE_COMMON.pick_random()
	price_dict.dd = PRICE_COMMON.pick_random()
	price_dict.ee = PRICE_COMMON.pick_random()
	price_dict.ff = PRICE_COMMON.pick_random()
	price_dict.gg = PRICE_COMMON.pick_random()
	price_dict.hh = PRICE_COMMON.pick_random()
	price_dict.ii = PRICE_COMMON.pick_random()
	price_dict.jj = PRICE_COMMON.pick_random()
	price_dict.kk = PRICE_COMMON.pick_random()
	price_dict.ll = PRICE_COMMON.pick_random()
	price_dict.mm = PRICE_COMMON.pick_random()
	price_dict.nn = PRICE_COMMON.pick_random()
	
	price_dict.oo = PRICE_UNCOMMON.pick_random()
	price_dict.pp = PRICE_UNCOMMON.pick_random()
	price_dict.qq = PRICE_UNCOMMON.pick_random()
	price_dict.rr = PRICE_UNCOMMON.pick_random()
	price_dict.ss = PRICE_UNCOMMON.pick_random()
	price_dict.tt = PRICE_UNCOMMON.pick_random()
	price_dict.uu = PRICE_UNCOMMON.pick_random()
	price_dict.vv = PRICE_UNCOMMON.pick_random()
	
	price_dict.ww = PRICE_RARE.pick_random()
	price_dict.xx = PRICE_RARE.pick_random()
	price_dict.yy = PRICE_RARE.pick_random()
	
	price_dict.zz = PRICE_SECRET.pick_random()
	
	price_dict.ex_misprint =  PRICE_EXRTA.pick_random()
	
