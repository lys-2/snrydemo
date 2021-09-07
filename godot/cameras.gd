extends Control

var c = preload("res://freecam2.tscn")

# Called when the node enters the scene tree for the first time.
func _ready():
	
	for row in range(10):
	
		for col in range(15):
		
			var c1 = c.instance()
			
			add_child(c1)
			c1.margin_left = 100*col
			c1.margin_top = 100*row


	
