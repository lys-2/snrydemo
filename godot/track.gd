extends Spatial

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	# print(translation)
	pass

func _input(event):
	if Input.is_action_just_pressed("switch"):
		var i = get_children()[rand_range(0, get_children().size())]
		i.controlled = true
		i.get_node('Body/CameraBase/Camera').current = true

