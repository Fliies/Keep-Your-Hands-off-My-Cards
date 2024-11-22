extends Node

												#ideal #garuntee 5 box, 50 packs, 250 card
# 14 common		a b c d e f g h i j k l m n		70%		60%		149+mp 		74.5
# 8 uncommon	o p q r s t u v					20%		33.6%	84			168
# 3 rare		w x y							9%		6%		15			300
# 1 secret		z								1%		0.4% 	1			50
# 1 misprint	mp												*1			15
# 5 box = 250 cards avr. 12x per box

## 1st 5 pack -> 25
# 22 cu 
# 2 rare 
# 1 misprint ; no.23rd


@export_category("PRICE RANGE")
#@export var PRICE_COMMON:Array[float] = [1.0, 1.5, 2.0, 2.5, 3.0 ]
#@export var PRICE_UNCOMMON:Array[float] = [6.5, 7.0, 7.5, 8.0, 8.5, 9.0, 9.5]
#@export var PRICE_RARE:Array[float] = [45.0, 50.0, 60.0]
@export var PRICE_COMMON:Array[float] = [0.25, 0.75]
@export var PRICE_UNCOMMON:Array[float] = [1.0, 3.0]
@export var PRICE_RARE:Array[float] = [15.0, 25.0]
@export var PRICE_SECRET:Array[float] = [100.0, 110.0]
@export var PRICE_EXRTA:Array[float] = [10.0, 20.0]

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
@onready var codename_arr:= [
	"aa", "bb", "cc", "dd", "ee", "ff", "gg", "hh", "ii", "jj", "kk", "ll", "mm",
	"nn", "oo", "pp", "qq", "rr", "ss", "tt", "uu", "vv", "ww", "xx", "yy", "zz",
	]
@onready var hellmode_arr:= [
	"aa", "bb", "cc", "dd", "ee", "ff", "gg", "hh", "ii", "jj", "kk", "ll", "mm",
	"nn", "oo", "pp", "qq", "rr", "ss", "tt", "uu", "vv", "ww", "xx", "yy", "zz",
	"ex_misprint"
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
@onready var shop_arr:= []
@onready var money_current: float = 0.0
@onready var money_added: float = 0.0
@onready var card_sell_arr:= []

@onready var price_dict: Dictionary = {}

@onready var starting_arr: bool = true
@onready var STARTING_money: float = 20.0
@onready var STARTING_packs: int = 10

@onready var price_pack: float = 10.0
@onready var price_box: float = 90.0

@onready var shop_promo: bool = true
@onready var newgame:bool = true
@onready var driver:bool = false
@onready var completed: bool = false
@onready var hellmode:bool = false


func _ready() -> void:
	_update_price()

func _process(_delta: float) -> void:
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
	##HELPER
	if total_open_packcount == 10: #garuntee rare 
		rng = 10
	
	##STARTER
	if total_open_packcount == 1: 
		rng = 1
	if total_open_packcount == 2: 
		rng = 1
	if total_open_packcount == 3: 
		rng = 1
	#garuntee rare 
	if total_open_packcount == 3: 
		rng = 8
	if total_open_packcount == 4: 
		rng = 8
	#garuntee misprint
	if total_open_packcount == 5: 
		rng = 1
	
	
	
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
	##droplist check
	#starting arr
	if starting_arr == true: 
		starting_arr = false
		## 1st 5 pack -> 25 (box_cu_arr,box_rs_arr)
		# 22 cu 
		# 2 rare (10 safety)
		# 1 misprint ; no.22rd
		
		# setup + shuffle temp_cu_arr
		var temp_cu_arr:= []
		temp_cu_arr.append_array(common_arr)
		temp_cu_arr.append_array(uncommon_arr)
		temp_cu_arr.shuffle()
		# pick 22 cards -> add to box_cu_arr
		while box_cu_arr.size() < 21:
			box_cu_arr.append(temp_cu_arr.pop_front())
		# add misprint in position 23rd
		box_cu_arr.append_array(misprint_arr)
		# add the rest of cu_arr
		box_cu_arr.append_array(temp_cu_arr)
		
		# setup + shuffle temp_rs_arr
		var temp_rs_arr:= []
		temp_rs_arr.append_array(rare_arr)
		temp_rs_arr.shuffle()
		# pick 10 card -> add to box_rs_arr (10 safety)
		while box_rs_arr.size() < 10 :
			box_rs_arr.append(temp_rs_arr.pop_front())
		# add "zz" to temp_rs_arr
		temp_rs_arr.append_array(secret_arr)
		# shuffle temp_rs_arr
		temp_rs_arr.shuffle()
		# add the rest of temp_rs_arr  to box_rs_arr
		box_rs_arr.append_array(temp_rs_arr)
	
	##Make sure drop_list not empty
		#normal arr
	if box_cu_arr.size() == 0 and box_rs_arr.size() == 0:
		_setup_droplist_arr(box_cu_arr, box_rs_arr)
	
	if single_cu_arr.size() == 0 and single_rs_arr.size() == 0:
		_setup_droplist_arr(single_cu_arr, single_rs_arr)
	
	##use SINGLE_arr before BOX_arr
	if packcount_single > 0:
		packcount_single -= 1
		_setup_cardpack_arr(single_cu_arr, single_rs_arr)
	
	elif packcount_single == 0 and packcount_box > 0:
		packcount_box -= 1
		_setup_cardpack_arr(box_cu_arr, box_rs_arr)

func _setup_hellmode_openingpack_arr():
	##use SINGLE_arr before BOX_arr
	if packcount_single > 0:
		packcount_single -= 1
		
		opening_arr.append(hellmode_arr.pick_random())
		opening_arr.append(hellmode_arr.pick_random())
		opening_arr.append(hellmode_arr.pick_random())
		opening_arr.append(hellmode_arr.pick_random())
		opening_arr.append(hellmode_arr.pick_random())
	
	elif packcount_single == 0 and packcount_box > 0:
		packcount_box -= 1
		
		opening_arr.append(hellmode_arr.pick_random())
		opening_arr.append(hellmode_arr.pick_random())
		opening_arr.append(hellmode_arr.pick_random())
		opening_arr.append(hellmode_arr.pick_random())
		opening_arr.append(hellmode_arr.pick_random())


func _action_sell():
	var card = opening_arr.pop_at(0)
	#handle money
	money_added += price_dict.get(card)

func _action_collect():
	var card = opening_arr.pop_at(0)
	collection_arr.append(card)

func _update_price():
	price_dict.clear()
	
	price_dict.aa = float( "%.2f" % randf_range(PRICE_COMMON[0],PRICE_COMMON[1]))
	
	#price_dict.aa = PRICE_COMMON.pick_random()
	price_dict.bb = float( "%.2f" % randf_range(PRICE_COMMON[0],PRICE_COMMON[1]))
	price_dict.cc = float( "%.2f" % randf_range(PRICE_COMMON[0],PRICE_COMMON[1]))
	price_dict.dd = float( "%.2f" % randf_range(PRICE_COMMON[0],PRICE_COMMON[1]))
	price_dict.ee = float( "%.2f" % randf_range(PRICE_COMMON[0],PRICE_COMMON[1]))
	price_dict.ff = float( "%.2f" % randf_range(PRICE_COMMON[0],PRICE_COMMON[1]))
	price_dict.gg = float( "%.2f" % randf_range(PRICE_COMMON[0],PRICE_COMMON[1]))
	price_dict.hh = float( "%.2f" % randf_range(PRICE_COMMON[0],PRICE_COMMON[1]))
	price_dict.ii = float( "%.2f" % randf_range(PRICE_COMMON[0],PRICE_COMMON[1]))
	price_dict.jj = float( "%.2f" % randf_range(PRICE_COMMON[0],PRICE_COMMON[1]))
	price_dict.kk = float( "%.2f" % randf_range(PRICE_COMMON[0],PRICE_COMMON[1]))
	price_dict.ll = float( "%.2f" % randf_range(PRICE_COMMON[0],PRICE_COMMON[1]))
	price_dict.mm = float( "%.2f" % randf_range(PRICE_COMMON[0],PRICE_COMMON[1]))
	price_dict.nn = float( "%.2f" % randf_range(PRICE_COMMON[0],PRICE_COMMON[1]))
	
	price_dict.oo = float( "%.2f" % randf_range(PRICE_UNCOMMON[0],PRICE_UNCOMMON[1]))
	price_dict.pp = float( "%.2f" % randf_range(PRICE_UNCOMMON[0],PRICE_UNCOMMON[1]))
	price_dict.qq = float( "%.2f" % randf_range(PRICE_UNCOMMON[0],PRICE_UNCOMMON[1]))
	price_dict.rr = float( "%.2f" % randf_range(PRICE_UNCOMMON[0],PRICE_UNCOMMON[1]))
	price_dict.ss = float( "%.2f" % randf_range(PRICE_UNCOMMON[0],PRICE_UNCOMMON[1]))
	price_dict.tt = float( "%.2f" % randf_range(PRICE_UNCOMMON[0],PRICE_UNCOMMON[1]))
	price_dict.uu = float( "%.2f" % randf_range(PRICE_UNCOMMON[0],PRICE_UNCOMMON[1]))
	price_dict.vv = float( "%.2f" % randf_range(PRICE_UNCOMMON[0],PRICE_UNCOMMON[1]))
	
	price_dict.ww = float( "%.2f" % randf_range(PRICE_RARE[0],PRICE_RARE[1]))
	price_dict.xx = float( "%.2f" % randf_range(PRICE_RARE[0],PRICE_RARE[1]))
	price_dict.yy = float( "%.2f" % randf_range(PRICE_RARE[0],PRICE_RARE[1]))
	
	price_dict.zz =float( "%.2f" % randf_range(PRICE_SECRET[0],PRICE_SECRET[1]))
	
	price_dict.ex_misprint =  float( "%.2f" % randf_range(PRICE_EXRTA[0],PRICE_EXRTA[1]))
