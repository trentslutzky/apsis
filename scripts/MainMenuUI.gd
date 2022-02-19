extends Control

func _process(_delta):
	visible = GameLoop.game_state == 0
	
func _on_quit_button_pressed():
	get_tree().quit()

func audio_hover():
	get_node("../../audio_hover").play()
	get_node("../../audio_hover").pitch_scale = rand_range(0.9,1.1)

func audio_select():
	get_node("../../audio_select").play()
	get_node("../../audio_select").pitch_scale = rand_range(0.9,1.1)

func _on_start_button_pressed():
	audio_select()
	GameLoop.game_state = 3

func _on_settings_button_pressed():
	audio_select()

func _on_start_button_mouse_entered():
	audio_hover()

func _on_settings_button_mouse_entered():
	audio_hover()

func _on_quit_button_mouse_entered():
	audio_hover()
