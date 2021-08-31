tool
extends EditorScript


# Declare member variables here. Examples:
# var a = 2
# var b = "text"


# Called when the node enters the scene tree for the first time.
func _run():
	var parent = get_scene().find_node("res://Target.gd") # Parent could be any node in the scene
	print(parent)
	var node = Spatial.new()
	parent.add_child(node)
	node.set_owner(get_scene())
# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta):
#	pass
