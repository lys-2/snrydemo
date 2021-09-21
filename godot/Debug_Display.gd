extends Control

func _ready():
	# Set the OS label and the engine version label
	$OS_Label.text = OS.get_name()
	#$Engine_Label.text = "Godot version:" + Engine.get_version_info()["string"]
	Engine.target_fps = 32
	
func _process(delta):
	# Update the FPS label
	$FPS_Label.text = str(Engine.get_frames_per_second())
	$MEM_Label.text = str(OS.get_static_memory_usage()/1000000)
