extends KinematicBody2D

###

export (int) var run_speed = 500
export (int) var jump_speed = -800
export (int) var gravity = 2000


var velocity = Vector2.ZERO
var jumping = false
var input_movement = false

var plant_detected = false
var plant_holding = false
###


func _ready():
	if not plant_holding:
		$Pickup/Plant.hide()


func _input(event):
	velocity.x = 0
	
	var right = Input.is_action_pressed('ui_right')
	var left = Input.is_action_pressed('ui_left')
	var jump = Input.is_action_just_pressed('ui_up')
	
	input_movement = right or left
	
	if jump and is_on_floor():
		jumping = true
		velocity.y = jump_speed
	if right and not is_on_wall():
		velocity.x += run_speed
	if left and not is_on_wall():
		velocity.x -= run_speed
	
#	if left:
#		$Camera.offset_h = -1
#	elif right:
#		$Camera.offset_h = 1
	
	if Input.is_action_just_pressed("ui_select") and plant_detected:
		plant_detected.queue_free()
		plant_holding = true
		$Pickup/Plant.show()
		$AnimationPlayer.play("flower_picking")


func _physics_process(delta):
	velocity.y += gravity * delta
	
	if jumping and is_on_floor():
		jumping = false
	
	# Prevent sliding
	if is_on_floor() and not input_movement:
		velocity.x = 0
	
	velocity = move_and_slide(velocity, Vector2.UP, true, 4, deg2rad(80))
	

func _on_Detection_body_entered(body):
	if body.name == "Plant":
		$AnimationPlayer.play("flower_detected")
		plant_detected = body


func _on_Detection_body_exited(body):
	if body.name == "Plant":
		if not plant_holding:
			$AnimationPlayer.play_backwards("flower_detected")
		plant_detected = null
