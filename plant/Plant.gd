extends RigidBody2D

var pickable = true

func _ready():
	pass # Replace with function body.


func picked():
	$Particles.emitting = false
	$Particles.restart()
	hide()
	call_deferred("change_mode", RigidBody2D.MODE_STATIC, null)
	set_collision_layer_bit(2, false)


func dropped(velocity):
	$Particles.emitting = true
	show()
	call_deferred("change_mode", RigidBody2D.MODE_RIGID, velocity)
	
	
	set_collision_layer_bit(2, true)
	rotation = 0


func change_mode(n_mode, velocity):
	mode = n_mode
	
	if velocity:
		apply_impulse(Vector2(10, 10), velocity * 50)

