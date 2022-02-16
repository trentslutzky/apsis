extends Camera2D

var target_zoom = Vector2(1,1)
var target_offset = Vector2(0,0)

func _process(_delta):
	if(GameLoop.game_state == 0 or GameLoop.game_state == 2):
		return	

	if(GameLoop.game_state == 1):
		target_zoom = Vector2(1,1)
		target_offset = Vector2(0,0)
	elif(GameLoop.game_state == 3):
		target_zoom = Vector2(0.5,0.5)
		target_offset = Vector2(200,0)
		
	self.position = lerp(self.position, get_node("../Player").position, 0.04)
	self.zoom = lerp(self.zoom, target_zoom, 0.02)
	self.offset = lerp(self.offset, target_offset, 0.02)
