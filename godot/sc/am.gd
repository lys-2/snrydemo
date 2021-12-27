extends MeshInstance


# Declare member variables here. Examples:
# var a = 2
# var b = "text"
var mt = preload("res://mt/fx.material")

# Called when the node enters the scene tree for the first time.
func _ready():

	var vertices = PoolVector3Array()
	for n in 10:

		var point = Vector3(rand_range(-500,500), rand_range(-10,100), rand_range(-500,500))
		var point2 = Vector3(1,10,1)
		vertices.push_back(point)
		vertices.push_back(point+point2)
		# print(point)

		# vertices.push_back(Vector3(rand_range(0,1), 0, 0))
		# vertices.push_back(Vector3(0, 0, rand_range(0,1)))
	# Initialize the ArrayMesh.
	var arr_mesh = ArrayMesh.new()
	var arrays = []
	arrays.resize(ArrayMesh.ARRAY_MAX)
	arrays[ArrayMesh.ARRAY_VERTEX] = vertices
	# Create the Mesh.
	arr_mesh.add_surface_from_arrays(1, arrays)

	# arr_mesh.add_surface_from_arrays(0, arrays)

	mesh = arr_mesh

	set_surface_material(0, mt)
	


# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta):
#	pass
