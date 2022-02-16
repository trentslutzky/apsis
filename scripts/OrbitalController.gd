extends Node2D

export var starting_angle = 0
export var rotate_speed = 1
export var distance = 75
export var size = 10

# orbital type enums
enum ORBITAL_TYPES {RANGER,BRAWLER}
export(ORBITAL_TYPES) var orbital_type = ORBITAL_TYPES.RANGER

# ranger stuff
export(Color) var ranger_color = Color(0,189,255,255)
export(float) var ranger_attack_speed = 1
export var ranger_range = 300
export var ranger_projectile_speed = 500
export var ranger_projectile_damage = 10
export (PackedScene) var projectile
var shot_timer : Timer = null
var bodies_in_range = []

# brawler stuff
export(Color) var brawler_color = Color(239,181,27,255)
export var brawler_contact_damage = 50

var target : Node2D = null
var angle = 0

func _ready():
	# set starting angle
	angle = deg2rad(starting_angle)
	
	if(orbital_type == ORBITAL_TYPES.RANGER):
		$Sat/Sprite.modulate = ranger_color
		# get timer node and set to random time ()
		shot_timer = get_node("ShotTimer")
		shot_timer.start(rand_range(0,ranger_attack_speed))
		
	elif(orbital_type == ORBITAL_TYPES.BRAWLER):
		$Sat/Sprite.modulate = brawler_color
		
func _process(delta):
	update()
	# if the game is paused, only show the scale, color and movements.
	if(GameLoop.game_state == 0 or GameLoop.game_state == 2):
		return
	
	motion(delta)
	
	if(orbital_type == ORBITAL_TYPES.RANGER):
		ranger()
	elif(orbital_type == ORBITAL_TYPES.BRAWLER):
		brawler()
		
func motion(delta):
			# set the scale of the orbital
	$Sat.scale = Vector2(size*0.1,size*0.1)
	# constant rotation of orbital
	angle += rotate_speed*delta
	# rotate the orbital based on the angle
	$Sat.position = Vector2(distance*cos(angle),distance*sin(angle))
		
func ranger():
	$Sat/Sprite.modulate = ranger_color
	# orbital looks at the target (for aiming)
	if(is_instance_valid(target)):
		$Sat.look_at(target.global_position)

func brawler():
	$Sat/Sprite.modulate = brawler_color
	pass

func _on_ShotTimer_timeout():
	if(GameLoop.game_state != 1):
		return
	if(orbital_type != ORBITAL_TYPES.RANGER):
		return
	if(is_instance_valid(target)):
		$AudioStreamPlayer2D.pitch_scale = rand_range(0.9,1.1)
		$AudioStreamPlayer2D.play()
		var b = projectile.instance()
		get_tree().current_scene.add_child(b)
		b.position = $Sat.global_position
		b.rotation_degrees = $Sat.rotation_degrees
		b.get_node("Sprite").modulate = $Sat/Sprite.modulate
		b.speed = ranger_projectile_speed

func _on_collision_area_body_entered(body):
	if(GameLoop.game_state != 1):
		return
	if(orbital_type != ORBITAL_TYPES.BRAWLER):
		return
	if(!body.is_in_group("Player")):
		if body.has_method("hit"):
			body.hit(brawler_contact_damage)

func _draw():
	if(GameLoop.draw_debug == false):
		return
	if(orbital_type == ORBITAL_TYPES.RANGER):
		draw_circle($Sat.position,ranger_range,Color(1,0,0,0.1))

func _on_range_body_entered(body):
	bodies_in_range.append(body)

func _on_range_body_exited(body):
	pass # Replace with function body.
