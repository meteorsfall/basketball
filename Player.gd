extends KinematicBody

# Declare member variables here. Examples:
# var a = 2
# var b = "text"
var gravity = -9.8
var velocity = Vector3(0,0,0)
onready var player_mesh = get_node("Player_Mesh")
onready var camera = get_node("Camera")
var rng = RandomNumberGenerator.new()

# Called when the node enters the scene tree for the first time.
func _ready():
	rng.randomize()

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	#if Input.is_key_pressed(KEY_LEFT):
	pass
	
	
var rotation_momentum = Vector3(0,0,0)

func _physics_process(delta):
	var rotation_change = Vector3(0,0,0)
	var rotation_constant = 0.03
	var translation_constant = 0.2 - Vector2(velocity.x, velocity.z).length()/50
	var friction = 0.994
	
	if Input.is_key_pressed(KEY_W):
		velocity.x += translation_constant
		rotation_change += Vector3(0,0,-1)
	if Input.is_key_pressed(KEY_S):
		velocity.x += -translation_constant
		rotation_change += Vector3(0,0,1)
	if Input.is_key_pressed(KEY_A):
		velocity.z += -translation_constant
		rotation_change += Vector3(-1,0,0)
	if Input.is_key_pressed(KEY_D):
		velocity.z += translation_constant
		rotation_change += Vector3(1,0,0)
	
	rotation_momentum += rotation_change * translation_constant / 10
	
	velocity.y += gravity*delta
	var collide = move_and_collide(velocity*delta)
	if collide:
		velocity = velocity.bounce(collide.normal)
		velocity.y *= 0.7
		velocity.x *= friction
		velocity.z *= friction
		rotation_momentum *= friction
		
		var rand_wobble = Vector3(rng.randf_range(-1,1), 0, rng.randf_range(-1,1)) * velocity.y
		rand_wobble *= 0.3
		velocity += rand_wobble
		rotation_momentum += Vector3(rand_wobble.z, 0, -rand_wobble.x) / 10
		#rotation_momentum += -velocity.cross(Vector3(0, 1, 0))*0.01
		if Input.is_key_pressed(KEY_SPACE):
			velocity.y += 20
			
	if rotation_momentum.length() > 0:
		player_mesh.rotate(rotation_momentum.normalized(), 
			rotation_momentum.length()*rotation_constant*PI)
