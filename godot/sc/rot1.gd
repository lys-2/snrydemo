extends Spatial


# Declare member variables here. Examples:
# var a = 2
# var b = "text"


# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.

func _process(delta):
	translate(Vector3(rand_range(0,10),rand_range(0,100),rand_range(0,10)))
	rotate_x(rand_range(0,1))
	rotate_y(rand_range(0,1))
	
	pass # Replace with function body.

# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta):
#	pass
