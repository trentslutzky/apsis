extends Control

func _process(_delta):
	visible = GameLoop.game_state == 2

func _on_quit_button_pressed():
	get_tree().quit()

func _on_start_button_pressed():
	GameLoop.game_state = 1

func _on_settings_button_pressed():
	pass # Replace with function body.
