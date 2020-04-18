extends KinematicBody2D

export (int) var ray_length = 800

onready var RayCast = $RayCast

enum {
	IDLE_STATE,
	WANDERING_STATE
}

var state = IDLE_STATE

var direction = Vector2(0, 0)

export (int) var move_speed = 200
export (NodePath) var patrol_path
var patrol_points
var patrol_index = 0
var velocity = Vector2.ZERO

func _ready():
	if patrol_path:
		patrol_points = get_node(patrol_path).curve.get_baked_points()
	update_raycast()


#func _input(event):
#	direction = Vector2.ZERO
#	if Input.is_action_pressed("ui_down"):
#		direction.y = 1
#	if Input.is_action_pressed("ui_up"):
#		direction.y = -1
#	if Input.is_action_pressed("ui_right"):
#		direction.x = 1
#	if Input.is_action_pressed("ui_left"):
#		direction.x = -1
#	update_raycast()


func update_raycast():
	RayCast.cast_to = velocity.normalized() * ray_length


func _physics_process(dt):
	if !patrol_path:
		return
	var target = patrol_points[patrol_index]
	if position.distance_to(target) < 10:
		patrol_index = wrapi(patrol_index + 1, 0, patrol_points.size())
		target = patrol_points[patrol_index]
	velocity = (target - position).normalized() * move_speed
	velocity = move_and_slide(velocity)
	update_raycast()
