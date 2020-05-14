extends KinematicBody

onready var player = get_node("../Player")

# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.

func game_over():
	get_tree().paused = true
	$"../Control/Game_Over_Popup".set_visible(true)
	$"../AudioStreamPlayer".playGameOverMusic()

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	var player_position = player.get_translation() 
	var current_position = get_translation()
	var direction = (player_position - current_position).normalized()
	move_and_slide(direction*100*delta)
	for i in range(0, get_slide_count()):
		var collision = get_slide_collision(i)
		if collision.get_collider_id() == get_node("../Player").get_instance_id():
			game_over()
