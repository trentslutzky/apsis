extends Area2D

export var speed = 750
export var damage = 10

func _physics_process(delta):
	if(GameLoop.game_state != 1):
		return
	position += transform.x * speed * delta

func _on_Shot_body_entered(body):
	if(!body.is_in_group("Player")):
		if body.has_method("hit"):
			body.hit(damage)
		queue_free()
