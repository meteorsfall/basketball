extends AudioStreamPlayer

# Called when the node enters the scene tree for the first time.
func _ready():
	pause_mode = Node.PAUSE_MODE_PROCESS
	stream.set_loop(true)
	play(130)

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass
	
func playGameOverMusic():
	stop()
	var audio_stream = load("res://game_over.ogg")
	audio_stream.set_loop(false)
	stream = audio_stream
	play()
