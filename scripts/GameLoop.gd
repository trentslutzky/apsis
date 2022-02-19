extends Node2D

# Game State
# 0 - Main Menu
# 1 - In Game
# 2 - Paused
var game_state = 0

var wave = 0

# turn on or off debug draws
var draw_debug = false

func _process(_delta):
	global_input()

func global_input():
	if Input.is_action_just_pressed('pause'):
		if game_state == 1:
			game_state = 2
		elif game_state == 2:
			game_state = 1
		

