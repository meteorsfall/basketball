extends RichTextLabel

onready var start_time = OS.get_ticks_msec()

# Called when the node enters the scene tree for the first time.
func _ready():
	clear()
	add_text("hello")

func _process(delta):
	var time = (OS.get_ticks_msec() - start_time)/1000
	clear()
	add_text(str(time)+"s")
