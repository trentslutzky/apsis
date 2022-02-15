extends Node2D

export var starting_angle = 0
export var rotate_speed = 1
export var distance = 75
export var size = 10

# orbital type enums
enum ORBITAL_TYPES {RANGER,BRAWLER}
export(ORBITAL_TYPES) var orbital_type = ORBITAL_TYPES.RANGER

# ranger stuff
export(float) var ranger_attack_speed = 1
export var ranger_projectile_speed = 500
export var ranger_projectile_damage = 10
export (PackedScene) var projectile
var shot_timer : Timer = null

var target : Node2D = null
var angle = 0

func _ready():
	# set starting angle
	angle = deg2rad(starting_angle)
	
	# get timer node and set to random time ()
	shot_timer = get_node("ShotTimer")
	shot_timer.start(rand_range(0,ranger_attack_speed))
	
	# temporary for testing
	target = get_node("../../Enemy")

func _physics_process(delta):
		# set the scale of the orbital
	$Sat.scale = Vector2(size*0.1,size*0.1)
	# constant rotation of orbital
	angle += rotate_speed*delta
	# rotate the orbital based on the angle
	$Sat.position = Vector2(distance*cos(angle),distance*sin(angle))
	# orbital looks at the target (for aiming)
	if(is_instance_valid(target)):
		$Sat.look_at(target.global_position)


func _on_ShotTimer_timeout():
	if(is_instance_valid(target)):
		$AudioStreamPlayer2D.pitch_scale = rand_range(0.9,1.1)
		$AudioStreamPlayer2D.play()
		var b = projectile.instance()
		get_tree().current_scene.add_child(b)
		b.position = $Sat.global_position
		b.rotation_degrees = $Sat.rotation_degrees
		b.get_node("Sprite").modulate = $Sat/Sprite.modulate
		b.speed = ranger_projectile_speed
