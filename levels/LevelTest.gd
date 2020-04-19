extends Node

var first_pickup = true

func _ready():
	$Player.connect("drop_plant", self, "_on_drop_plant")
	$Player.connect("pick_plant", self, "_on_pick_plant")
	pass


func _on_drop_plant(position, velocity):
	$Plant.dropped(velocity)
	$Plant.position = position


func _on_pick_plant():
	$Plant.picked()
	
	if first_pickup:
		$Plant.start_timer()
		$Tween.interpolate_property($LightingThePlant, "energy", $LightingThePlant.energy, 0, 5, Tween.TRANS_BACK, Tween.EASE_OUT)
		$Tween.start()
		yield($Tween, "tween_all_completed")
		$LightingThePlant.queue_free()
	
	first_pickup = false

