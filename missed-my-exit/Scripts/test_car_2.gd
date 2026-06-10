extends VehicleBody3D

var max_RPM = 450
var max_torque = 300
var turn_speed = 3
var turn_amount = 0.3

#Camera
var mouse_sensitivity = 0.3
@onready var car_camera: Camera3D = $Head/CarCamera
@onready var head: Node3D = $Head

#Player Point and Door
@onready var player_point: Marker3D = $PlayerPoint
@onready var drivers_door: Area3D = $PlayerPoint/DriversDoor


func _process(delta: float) -> void:
	Global.PlayerMarker = player_point.global_position
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
	else: 
		var body_list = drivers_door.get_overlapping_bodies()
		if drivers_door.has_overlapping_bodies():
			for body in body_list:
				if body.is_in_group("Player"):
					Global.NearDoor = true
				else: Global.NearDoor = false
		else: Global.NearDoor = false

func _input(event):
	if event is InputEventMouseMotion:
		head.rotation_degrees.y -= event.relative.x * mouse_sensitivity
		head.rotation_degrees.y = clampf(head.rotation_degrees.y,-80,80)
		head.rotation_degrees.x -= event.relative.y * mouse_sensitivity
		head.rotation_degrees.x = clampf(head.rotation_degrees.x,-45,90)
