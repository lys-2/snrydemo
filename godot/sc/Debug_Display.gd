extends Control
signal labels(n, s)

# Called when the node enters the scene tree for the first time.
var b = preload("res://label1.tscn")

func _ready():

	connect("labels", self, "labels")
	
	for e in 48:
		var b1 = b.instance()
		add_child(b1)
		b1.text = "  | ||"+str(e)
		b1.margin_top = 16*e+128
		b1.add_color_override("font_color",
		 Color.from_hsv(rand_range(0,1), 1.0, 1.0, 1.0))
#		b1.name = "l"+str(e)

#		b.add_font_override("res://new_dynamicfont.tres")
#		b.add_color_override()

	$OS_Label.text = OS.get_name()
	#$Engine_Label.text = "Godot version:" + Engine.get_version_info()["string"]
	Engine.target_fps = 0
	
func _process(delta):
	# Update the FPS label
	$FPS_Label.text = str(Engine.get_frames_per_second())
	$MEM_Label.text = str(OS.get_static_memory_usage()/1000000)
	if Input.is_action_pressed("restart"):
		get_tree().reload_current_scene()
	if Input.is_action_pressed("quit"):
		get_tree().quit()

	emit_signal("labels", rand_range(1,48), rand_range(1,111111))

	
func labels(n,s):
	get_child(n+3).text = '1'

