tool
extends EditorScript


# var c = preload("../18.obj")
var s = 3
var mt = preload("res://mt/sky.material")
var mt2 = preload("res://mt/gray.material")
var mt3 = preload("res://mt/white.material")

func _run():
	var parent = get_scene().find_node("Viewport")

	for child in parent.get_children():
		child.queue_free()

	for row in range(s):
		for col in range(s):
			var m = MeshInstance.new()

			m.mesh = preload('../18.obj')
#			m.set_surface_material(1, mt2)
#			m.set_surface_material(0, mt)
#			m.set_surface_material(2, mt3)
			var r = rand_range(-1000, 1000)
			var r2 = rand_range(-10, 10)
			m.translate(Vector3((row-s/2)*1000,r2*8,(col-s/2)*1000))
			m.rotate_y(rand_range(0, 360))

			parent.add_child(m)
			m.set_owner(get_scene())
			m.create_trimesh_collision()
			m.get_child(0).get_child(0).visible = 0
#			m.move_and_slide(Vector3(r, r, r))



   
