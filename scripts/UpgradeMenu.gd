extends Control

# menu state 
# 0 - starter menu
# 1 - primary menu
var menu_state = 0

onready var starter_orbital = $"../../../Level/Player/starter_orbital"

func _process(_delta):
	visible = GameLoop.game_state == 3
	$starter.visible = menu_state == 0
	$starter/start_button.visible = starter_orbital.visible

# starter screen
func _on_ranger_start_pressed():
	starter_orbital.visible = true
	starter_orbital.orbital_type = starter_orbital.ORBITAL_TYPES.RANGER
	starter_orbital.rotate_speed = 1
	starter_orbital.distance = 75
	starter_orbital.size = 9
	$starter/start_orbital_buttons/brawler_start.pressed = false
	$starter/start_orbital_buttons/ranger_start.pressed = true

func _on_brawler_start_pressed():
	starter_orbital.visible = true
	starter_orbital.orbital_type = starter_orbital.ORBITAL_TYPES.BRAWLER
	starter_orbital.rotate_speed = 3
	starter_orbital.distance = 100
	starter_orbital.size = 15
	$starter/start_orbital_buttons/brawler_start.pressed = true
	$starter/start_orbital_buttons/ranger_start.pressed = false

func _on_start_button_pressed():
	menu_state = 1
	GameLoop.game_state = 1
