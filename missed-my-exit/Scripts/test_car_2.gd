extends VehicleBody3D
class_name Car
var max_RPM = 450
var max_torque = 300
var turn_speed = 3
var turn_amount = 0.3

#Headlights
@onready var right_headlight: SpotLight3D = $RightHeadlight
@onready var left_headlight: SpotLight3D = $LeftHeadlight
var headlight = true

#Camera
var mouse_sensitivity = 0.3
@onready var car_camera: Camera3D = $Head/CarCamera
@onready var head: Node3D = $Head

#Player Point and Door
@onready var player_point: Marker3D = $PlayerPoint
@onready var drivers_door: Area3D = $PlayerPoint/DriversDoor

#Wheel & Dashboard
@onready var steering_wheel: Node3D = $THESTEERINGWHEEL
var steering_tilt = 6.5

#Audio
var direction_held = false
@onready var car_idle: AudioStreamPlayer = $Head/CarIdle
@onready var car_moving: AudioStreamPlayer = $Head/CarMoving
@onready var car_accelerate: AudioStreamPlayer = $Head/CarAccelerate
@onready var outside_ambience: AudioStreamPlayer = $Head/OutsideAmbience


#Trunk
@onready var trunk_animations: AnimationPlayer = $Trunk/TrunkAnimations
@onready var trunk_area: Area3D = $Trunk/TrunkArea

#movement popping what not
var air = 1.0

func open_trunk():
	if Global.tutorial_num == 3: Global.CurrentCheck = true
	trunk_animations.play("Trunk_Open")
	Global.TrunkOpened = true
	
func close_trunk():
	trunk_animations.play("Trunk_Close")
	Global.TrunkOpened = false
	

func headlights():
	if headlight: 
		right_headlight.show()
		left_headlight.show()
	else:
		right_headlight.hide()
		left_headlight.hide()

var pop_stage = 0
func pop_stages():
	if Global.TirePopped:
		match pop_stage:
			0:
				print("0")
				brake = 1
				air = .8
				$wheel_back_right.wheel_friction_slip = 20
				await get_tree().create_timer(.5).timeout
				pop_stage += 1
				pop_stages()
			1:
				print("1")
				brake = 20
				air = .1
				$wheel_back_right.wheel_friction_slip = 1000
				await get_tree().create_timer(1).timeout
				pop_stage += 1
				pop_stages()
			2:
				print("2")
				brake = 5000
				air = .0001
				$wheel_back_right.wheel_friction_slip = 100000
	else:
		air = 1.0
		$wheel_back_right.wheel_friction_slip = 10.5
		pop_stage = 0



func _ready():
	Global.TrunkOpened = false
	steering_tilt = deg_to_rad(steering_tilt)
	Input.set_mouse_mode(Input.MOUSE_MODE_CAPTURED)
	set_as_top_level(true)
	headlights() 


func _process(delta: float) -> void:
	Global.PlayerMarker = player_point.global_position
	#Switching
	if !Global.OnFoot:
		if !outside_ambience.playing: outside_ambience.play()
		if !Global.JustSwitched and Input.is_action_just_pressed("Interact"):
			Global.OnFoot = true
			Global.JustSwitched = true
		car_camera.make_current()
		headlights()
		if Input.is_action_just_pressed("ToggleLight"): 
			if Global.tutorial_num == 11: Global.CurrentCheck = true
			headlight = !headlight
			Global.TirePopped = !Global.TirePopped
			pop_stages()
		
		var dir = Input.get_action_strength("Forward") - Input.get_action_strength("Backward")
		var steering_dir = Input.get_action_strength("Left") - Input.get_action_strength("Right")
		#moves steering wheel resets z to get better rotation
		var steer_wheel_change = deg_to_rad(steering_dir)
		steering_wheel.rotate_x(steering_tilt)
		steering_wheel.rotate_z(steer_wheel_change)
		steering_wheel.rotate_x(-steering_tilt)
		var RPM_left = abs($wheel_back_left.get_rpm())
		
		var RPM_right = abs($wheel_back_right.get_rpm())
		var RPM = (RPM_left + RPM_right) / 2.0
		
		var torque = (dir * max_torque * (1.0 - RPM / max_RPM)) * air
			
		engine_force = torque
		steering = lerp(steering, steering_dir * turn_amount, turn_speed * delta)
		
		if dir == 0:
			direction_held = false
			brake = 2
		else:
			if !car_accelerate.playing and !direction_held: 
				car_accelerate.play()
				direction_held = true
		
		#print(RPM)
		if RPM > 1.0:
			car_idle.stop()
			if !car_moving.playing: car_moving.play()
		else:
			#print("test")
			car_moving.stop()
			if !car_idle.playing: car_idle.play()
	else: 
		#Audio
		outside_ambience.stop()
		car_idle.stop()
		car_moving.stop()
		car_accelerate.stop()
		var door_list = drivers_door.get_overlapping_bodies()
		var trunk_list = trunk_area.get_overlapping_bodies()
		if drivers_door.has_overlapping_bodies():
			for body in door_list:
				if body.is_in_group("Player"):
					Global.NearDoor = true
				else: Global.NearDoor = false
		else: Global.NearDoor = false
		if trunk_area.has_overlapping_bodies():
			for body in trunk_list:
				if body.is_in_group("Player"):
					if Input.is_action_just_pressed("Interact"):
						if Global.TrunkOpened and !Global.HasItem: close_trunk()
						else: open_trunk()

func _input(event):
	if event is InputEventMouseMotion:
		head.rotation_degrees.y -= event.relative.x * mouse_sensitivity
		head.rotation_degrees.y = clampf(head.rotation_degrees.y,-80,80)
		head.rotation_degrees.x -= event.relative.y * mouse_sensitivity
		head.rotation_degrees.x = clampf(head.rotation_degrees.x,-45,90)
