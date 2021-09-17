tool
extends Spatial
# Declare member variables here. Examples:
# var a = 2
# var b = "text"
onready var file = 'res://targets.txt'
func load_file(file):

	var f = File.new()
	f.open(file, File.READ)
	var i = 0
	var t = preload("res://Target.tscn")
	while not f.eof_reached(): # iterate through all lines until the end of file is reached
		
		var l  = f.get_line().split(', ')
		var n = t.instance()
		if l:
			add_child(n) # Parent could be any node in the scene
			n.set_owner(get_tree().edited_scene_root)
			print(l)
			n.translation += Vector3(l[0],l[1],l[2])
			n.rotate_y(rand_range(360, i))
			i += 1
		
	f.close()
	return

# Called when the node enters the scene tree for the first time.
func _ready():
	
	load_file(file)

# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta):
#	pass
