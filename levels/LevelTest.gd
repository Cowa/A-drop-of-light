extends Node

func _ready():
	$Player.connect("drop_plant", self, "_on_drop_plant")
	$Player.connect("pick_plant", self, "_on_pick_plant")
	pass


func _on_drop_plant(position, velocity):
	$Plant.dropped(velocity)
	$Plant.position = position


func _on_pick_plant():
	$Plant.picked()

