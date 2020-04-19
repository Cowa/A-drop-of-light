extends Node2D

func _ready():
	pass


func _on_PlantDetect_body_entered(body):
	print("plant detected")
	body.more_life()
	$Light.queue_free()
	pass # Replace with function body.
