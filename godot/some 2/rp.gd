extends Spatial


# Declare member variables here. Examples:
export var a = 2

export(float, 0, 1) var aaa = 0
# var b = "text"


# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta):
#	pass
func _physics_process(delta):
	translation+=Vector3(0.1,0,0)
