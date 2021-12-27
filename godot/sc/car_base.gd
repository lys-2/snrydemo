
extends Spatial
signal labels

# Declare member variables here. Examples:
# var a = 2
# var b = "text"
export var controlled = false

var i = 0
var ch = 0
var ch2 = 0
var s = 0
var l = 0
var c = 0
var r = 0
var m
var mt2 = preload("res://mt/white.material")
var chs = []
var mt = preload("res://mt/fx.material")
var m2
var arrays = []
var i2 = 0
var tx = load('res://res/tex3.png')
var m3 = MeshInstance.new()
var arr_mesh = ArrayMesh.new()


# Called when the node enters the scene tree for the first time.
func _ready():
	
	l = get_node("../../../../Debug_Display/MEM_Label2")

	mt2.flags_unshaded = true
	mt2.albedo_color = Color(0.7, 0.9, 0.8, 1)

	var tx = load("res://res/icon.png")
	var mt3 = mt2.duplicate()
	mt3.albedo_texture = tx
	mt3.uv1_scale = Vector3(2,2,2)
	mt3.uv1_offset = Vector3(rand_range(0,1),rand_range(0,1),rand_range(0,1))
	m = get_node('Body/CameraBase/MeshInstance')
	m.set_surface_material(0, mt3)

	get_node("../../scene").add_child(m3)



	arrays.resize(ArrayMesh.ARRAY_MAX)
	m3.mesh = arr_mesh
	arrays[0] = [Vector3(0,0,0),Vector3(0,0,0)]
	arr_mesh.add_surface_from_arrays(1, arrays)
	arr_mesh.surface_set_material(0, mt)


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):

	if controlled:

		s = get_child(0).global_transform.origin
		c = floor((s.x+1024*16)/1024+1)			
		r = floor((s.z+1024*16)/1024+1)
		ch = (c)+((r*32)-32)

		if i == 0:

			chs = [ch]

			draw_chunk(ch)
			# draw_chunk2(ch)

			# print(chs)

		if i < len(chs):
			# chs.append_array([randi() % 1024])
			if i == 0:
				chs = get_n_chunks(chs, 4)
				chs.pop_front()
			if chs[i] in range(1, 1024):
				if i < 12:
					draw_chunk(chs[i])
				if i > 5:
					draw_chunk2(chs[i])
			
			# print(chs)

		if not i%16 or not i:
			# emit_signal('labels', 1, "1")
			l.text = str(ch)
			if i < 11:
				draw_multimesh()
			# print(r, ' ' ,  c, ' ', ch, ' ', s, ' ', delta)

		i = i + 1

		get_node('Body/SpotLight').visible = 0
		if Input.is_action_pressed("accelerate"):
			get_node('Body/SpotLight').visible = 1

	# emit_signal("health_depleted")

var ipp = 0

func _physics_process(delta):
	if controlled:
		if not ipp%300:
			# print(delta)
			draw_line()
		ipp = ipp+1

func draw_line():
	
	s = get_child(0).global_transform.origin
	var space_state = get_world().direct_space_state
	var lines = []
	
	for e in 1111:
		var s1 = Vector3(s[0]+rand_range(-150,150),s[1]+rand_range(0,3),s[2]+rand_range(-150,150))
		var s2 = s1-Vector3(0, 200, 0)
		r = space_state.intersect_ray(s1, s2)
		if r.has('position'):
			lines.append_array([s1, s2, r.position, r.position+Vector3(1,1,1)])
			pass
	arrays[0] = lines
	arr_mesh.surface_remove(0)
	arr_mesh.add_surface_from_arrays(1, arrays)
	var mt3 = mt.duplicate()
	mt3.albedo_color= Color.from_hsv(rand_range(0,0.5), 0.5, 0.5, 1.0)
	if arr_mesh.get_surface_count():
		arr_mesh.surface_set_material(0, mt3)

func get_n_chunks(chs, d):

	if d == 0:
		return chs
	var chs2 = []
	for ch in chs:
		r = [ch, ch-1, ch+1, ch+32, ch-32, (ch+32)-1, (ch+32)+1, (ch-32)+1, (ch-32)-1]
		for e in r:
			if not chs2.has(e):
				chs2.append(e)
			# print(chs2)

	return get_n_chunks(chs2, d-1)

func draw_chunk(ch):

	m = MeshInstance.new()
	
	var sf = "res/ch/%d.obj" % ch
	# print(sf)
	m.mesh = load(sf)

	m.create_trimesh_collision()
	get_node("../../scene").add_child(m)

	for e in m.get_surface_material_count():
		m.set_surface_material(e, mt2)
	# m.set_surface_material(2, mt2)
	

func draw_multimesh():


	var t1 = load("res/tree.obj")
	var t2 = MeshInstance.new()
	t2.mesh = t1
	var s = StaticBody.new()
	# var s1 = CollisionShape.new()
	# var s2 = ConvexPolygonShape.new()

	t2.create_convex_collision()
	# s.add_child(t2.get_child(0))


	var m4 = MultiMeshInstance.new()
	m4.multimesh = MultiMesh.new()
	m4.multimesh.transform_format = MultiMesh.TRANSFORM_3D
	m4.multimesh.color_format = MultiMesh.COLOR_NONE
	m4.multimesh.custom_data_format = MultiMesh.CUSTOM_DATA_NONE
	# Then resize (otherwise, changing the format is not allowed).
	m4.multimesh.instance_count = 500
	# # Maybe not all of them should be visible at first.
	m4.multimesh.visible_instance_count = 500
	for i in m4.multimesh.visible_instance_count:
		m4.multimesh.set_instance_transform(i, Transform(Basis(),
		 Vector3(rand_range(-500,500), 0, rand_range(-500,500))))
		# var t3 = t2.get_child(0).duplicate()
		


		# get_parent().add_child(t3)
		

	


	m4.multimesh.mesh = t1
	m4.multimesh.mesh.surface_set_material(0, mt)

	get_node("../../scene").add_child(m4)
	# m4.set_owner(self)
	


func draw_chunk2(ch):

	m = MeshInstance.new()
	m2 = MeshInstance.new()
	
	var sf = "res/ch/%d.obj" % ch
	# print(sf)
	m.mesh = load(sf)
	
	# print(m.mesh.get_surface_count())
	var t = "res/tree.obj"
	# var t1 = load(t)
	# var t2 = t1.get


	var arr_mesh = ArrayMesh.new()
	arrays.resize(ArrayMesh.ARRAY_MAX)
	arrays[0] = m.mesh.surface_get_arrays(0)[0]

	var a2 = []
 
	for e in arrays[0]:
		if not i2%14:
			a2.append(e)
		i2= i2+1

	# a2.append(t1.get_faces())
	# print(a2)
	# print(t[0])
	arrays[0] = a2
	# # # Create the Mesh.	print(arrays[0].size())
	m.queue_free()
	arr_mesh.add_surface_from_arrays(1, arrays)

	m2.mesh = arr_mesh

	m2.set_surface_material(0, mt)
	get_node("../../scene").add_child(m2)
	# m2.set_owner(self)
