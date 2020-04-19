extends RigidBody2D

var pickable = true

onready var PowerLight = $Light

signal dead

func _ready():
	$Timer.connect("timeout", self, "_timer_timeout")


func start_timer():
	$Timer.start()


func stop_timer():
	$Timer.stop()


func _timer_timeout():
	$Tween.interpolate_property(PowerLight, "texture_scale", PowerLight.texture_scale, PowerLight.texture_scale - 0.5, 0.5, Tween.TRANS_BACK, Tween.EASE_OUT)
	$Tween.start()
	
	yield($Tween, "tween_all_completed")
	
	if PowerLight.texture_scale < 0:
		print("dead")
		emit_signal("dead")
	else:
		start_timer()


func picked():
	$Particles.emitting = false
	$Particles.restart()
	hide()
	call_deferred("change_mode", RigidBody2D.MODE_STATIC, null)
	set_collision_layer_bit(2, false)


func sync_with(other_plant):
	PowerLight.texture_scale = other_plant.PowerLight.texture_scale
	PowerLight.energy = other_plant.PowerLight.energy
	PowerLight.color = other_plant.PowerLight.color
	
	#$Timer.wait_time = other_plant.get_node("Timer").time_left



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


func more_life():
	PowerLight.texture_scale += 0.5
