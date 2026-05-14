extends VehicleBody3D

var max_RPM = 450
var max_torque = 300
var turn_speed = 3
var turn_amount = 0.3

#Camera
@onready var car_camera: Camera3D = $CarCamera


func _process(delta: float) -> void:
	#Switching
	if !Global.OnFoot:
		if !Global.JustSwitched and Input.is_action_just_pressed("SwitchControls"):
			Global.OnFoot = true
			Global.JustSwitched = true
		car_camera.make_current()
		var dir = Input.get_action_strength("Forward") - Input.get_action_strength("Backward")
		var steering_dir = Input.get_action_strength("Left") - Input.get_action_strength("Right")
		
		var RPM_left = abs($wheel_back_left.get_rpm())
		var RPM_right = abs($wheel_back_right.get_rpm())
		var RPM = (RPM_left + RPM_right) / 2.0
		
		var torque = dir * max_torque * (1.0 - RPM / max_RPM)
		
		engine_force = torque
		steering = lerp(steering, steering_dir * turn_amount, turn_speed * delta)
		
		if dir == 0:
			brake = 2
