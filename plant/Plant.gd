extends RigidBody2D


func _ready():
	pass # Replace with function body.


func picked():
	hide()
	mode = RigidBody2D.MODE_STATIC
	set_collision_layer_bit(2, false)


func dropped():
	show()
	mode = RigidBody2D.MODE_RIGID
	set_collision_layer_bit(2, true)
	rotation = 0
