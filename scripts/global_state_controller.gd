extends Node

class_name GameStateController

@onready var current_state: GameState = GameState.STARTING_MENU
@onready var prev_state: GameState 

enum GameState {
	STARTING_MENU,
	ANIMATION,
	STANDBY, 
	OPENING_BACK,
	OPENING_FRONT, 
	SHOP_MENU,
	SHOP_OFFER,
	SHOP_CARDLIST,
	BINDER
}
