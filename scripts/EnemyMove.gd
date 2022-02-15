extends KinematicBody2D

var player

var move_speed = 60
var velocity = Vector2.ZERO

export var health = 100

func _ready():
	player = get_node("../Player")

func _physics_process(_delta):
	look_at(player.position)
	velocity = Vector2.ZERO
	if player:
		velocity = position.direction_to(player.position) * move_speed
	velocity = move_and_slide(velocity)

func hit(damage):
	health -= damage
	if(health <= 0):
		queue_free()
	print("I was hit")
