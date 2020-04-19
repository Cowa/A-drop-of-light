extends Node2D

var done = false

func _ready():
	$Label.modulate.a = 0.0
	pass


func _on_Area2D_area_entered(area):
	if done: return
	$Tween.interpolate_property($Label, "modulate", Color.transparent, Color.white, 0.5, Tween.TRANS_LINEAR)
	$Tween.start()


func _on_Area2D_area_exited(area):
	if done: return
	$Tween.interpolate_property($Label, "modulate", Color.white, Color.transparent, 0.5, Tween.TRANS_LINEAR)
	$Tween.start()
	done = true
