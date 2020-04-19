extends Node

var first_pickup = true

onready var Final = $Final

func _ready():
	$Player.connect("drop_plant", self, "_on_drop_plant")
	$Player.connect("pick_plant", self, "_on_pick_plant")
	
	$Plant.connect("dead", self, "_game_over")
	
	Final.connect("final_reached", self, "_the_end")
	pass


func _game_over():
	$Player.can_play = false
	$Player.velocity = Vector2.ZERO
	$AnimationPlayer.play("game_over")
	yield($AnimationPlayer, "animation_finished")
	$Timer.wait_time = 2
	$Timer.start()
	yield($Timer, "timeout")
	get_tree().reload_current_scene()


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


func _the_end():
	$Player.can_play = false
	$Timer.wait_time = 4
	$Timer.start()
	yield($Timer, "timeout")
	$AnimationPlayer.play("end")
	
