extends RigidBody2D

var pickable = true

var first_detect = true

export (bool) var player_attached = false

onready var PowerLight = $Light

signal dead

func _ready():
	$Timer.connect("timeout", self, "_timer_timeout")


func start_timer():
	$Timer.start()


func stop_timer():
	$Timer.stop()


func _timer_timeout():
	var from = PowerLight.texture_scale
	var to = max(PowerLight.texture_scale - 0.5, 0.0)
	
	
	$Tween.interpolate_property(PowerLight, "texture_scale", from, to, 0.5, Tween.TRANS_BACK, Tween.EASE_OUT)
	$Tween.start()
	
	yield($Tween, "tween_all_completed")
	
	if PowerLight.texture_scale <= 0.00001:
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
	var to = min(PowerLight.texture_scale + 1, 2.5)
	$Timer.stop()
	$Tween.interpolate_property(PowerLight, "texture_scale", PowerLight.texture_scale, to, 0.75, Tween.TRANS_BOUNCE, Tween.EASE_OUT)
	$Tween.start()
	yield($Tween, "tween_all_completed")
	$Timer.start()


func endless_life():
	$Timer.stop()
	$Tween.interpolate_property(PowerLight, "texture_scale", PowerLight.texture_scale, 50, 5, Tween.TRANS_BOUNCE, Tween.EASE_OUT)
	$Tween.start()


func _on_PickupShape_area_entered(area):
	if first_detect and not player_attached:
		$WelcomeAudio.play()
		first_detect = false



func _on_Plant_body_entered(body):
	if not $HitAudio.playing:
		$HitAudio.play()
	pass # Replace with function body.
