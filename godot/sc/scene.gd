extends Spatial

# Declare member variables here. Examples:
# var a = 2
# var b = "text"

# var c = preload("../res/ch/1.obj")

var s = 32
var mt = preload("res://mt/sky.material")
var mt2 = preload("res://mt/gray.material")
var mt3 = preload("res://mt/white.material")
var c1 = load("res://car1.tscn")
var p = load("res://points.tscn")
var b = preload("res://res/box.obj")

var file = 'res://targets.txt'
func parse_txt_to_list(file):

	var f = File.new()
	f.open(file, File.READ)
	var i = 0
	var t = load("res://car1.tscn")
	var l1 = []

	while i < 20: # iterate through all lines until the end of file is reached
		
		var l  = f.get_line().split(', ')
		l1.append(l)
		i += 1
		print(i)
		
	f.close()
	return l1


func _ready():
	
	var b1 = MeshInstance.new()
	b1.mesh = b
	
	var sp_list = parse_txt_to_list(file)

	var parent = self

	for child in self.get_children():
		child.queue_free()

	var car2 = c1.instance()
	var car3 = c1.instance()
	var car4 = c1.instance()
	
	var fx = p.instance()

	print(sp_list)
	var l = sp_list[rand_range(0,sp_list.size())]

	car2.translate(Vector3(l[0],l[1],l[2]))
	get_node("../controller").add_child(car2)
	car3.translate(Vector3(l[0],l[1],l[2])+Vector3(0,0,20))
	get_node("../controller").add_child(car3)	
	car4.translate(Vector3(l[0],l[1],l[2])+Vector3(10,20,10))
	get_node("../controller").add_child(car4)
	car2.controlled = true
	
	add_child(b1)
	
	var mt4 = mt3.duplicate()
	mt4.albedo_color = Color(0.1, 0.1, 0.1)
	b1.mesh.surface_set_material(0, mt4)
	b1.create_trimesh_collision()
	

	# fx.translate(Vector3(l[0],l[1],l[2]))
	fx.translate(Vector3(0,l[1],0)+Vector3(0,-10,0))
	add_child(fx)

	get_parent().msaa = 0

	for row in range(s):
		
		for col in range(s):
			return
			var n = row*s+col+1
			if n == 481:
				
				var m = MeshInstance.new()

				var sf = "res/ch/%d.obj" % n
				print(sf)
				m.mesh = load(sf)
			#	m.set_surface_material(0, mt3)
			#	m.set_surface_material(1, mt2)
			#	m.set_surface_material(2, mt3)
				# m.set_surface_material(3, mt2)
				var r = rand_range(-1000, 1000)
				var r2 = rand_range(-10, 10)
				# m.translate(Vector3((row-s/2)*1000,r2*8,(col-s/2)*1000))
				# m.rotate_y(rand_range(0, 360))
				
				parent.add_child(m)
				m.set_owner(self)
				m.create_trimesh_collision()
				# m.get_child(0).get_child(0).visible = 0
	#			m.move_and_slide(Vector3(r, r, r))


	# var car = c1.instance()
	# add_child(car)
	# car.translate(Vector3(0,100,0))


	
# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass
