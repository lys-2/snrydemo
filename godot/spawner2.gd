tool
extends EditorScript

var p = preload("res://Player.tscn")
var c = preload("res://freecam2.tscn")

func update_every(sec):

	update_every(sec)
# Called when the node enters the scene tree for the first time.
func _run():
	var parent = get_scene().find_node("players")
	var s = get_scene().find_node("Spatial")
	for child in parent.get_children():
		child.queue_free()
	var space_state = s.get_world().direct_space_state

	for row in range(30):
		for col in range(1):
			var c1 = p.instance()
			c1.set_owner(get_scene())
			var r = rand_range(-1000, 1000)
			var r2 = rand_range(-10, 10)
#			var result = space_state.intersect_ray(Vector3(r, 1000, r2),
#			 Vector3(r, -1000, r2))
#			print(result.position)
#			c1.name = str(row)
			parent.add_child(c1)
			c1.set_owner(get_scene())
			c1.move_and_slide(Vector3(r, r, r))
#			c1.margin_left = 300*col
#			c1.margin_top = 300*row


   
