extends Node2D

var paused = false
var in_menu = true

onready var main_menu = $"Menu/CanvasLayer/UI"
onready var level = $Level

func _ready():
	pass

func _on_start_button_pressed():
	main_menu.visible = false
