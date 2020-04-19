extends Node2D

export (bool) var final = false

signal final_reached

func _ready():
	pass


func _on_PlantDetect_body_entered(body):
	if not final:
		body.more_life()
		$Light.queue_free()
		$AudioPlayer.play()
	else:
		body.endless_life()
		emit_signal("final_reached")
		print("end")
	
