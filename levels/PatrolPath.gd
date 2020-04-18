tool
extends Path2D

onready var points = curve.get_baked_points()

func _ready():
	update()
	pass


func _draw():
	for p in points:
		pass#draw_circle(p, 10, Color.white)
