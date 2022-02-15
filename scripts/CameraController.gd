extends Camera2D

func _process(_delta):
	self.position = lerp(self.position, get_node("../Player").position, 0.04)
