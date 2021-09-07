tool
extends EditorScript

var c = preload("res://18.obj")
var s = 25

func _run():
	var parent = get_scene().find_node("map")
	for child in parent.get_children():
		child.queue_free()

	for row in range(s):
		for col in range(s):
			var m = MeshInstance.new()
			m.mesh = c
			var r = rand_range(-1000, 1000)
			var r2 = rand_range(-10, 10)
			m.translate(Vector3((row-s/2)*1000,r2*8,(col-s/2)*1000))
#			m.create_trimesh_collision()
			m.rotate_y(rand_range(0, 360))
			parent.add_child(m)
			m.set_owner(get_scene())
#			m.move_and_slide(Vector3(r, r, r))



   
