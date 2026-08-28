extends CharacterBody3D
class_name Player

#Base Speed
var SPEED = 5.0
const JUMP_VELOCITY = 4.5

#Sprinting
const RUN_SPEED: float = 5.0
var WALK_SPEED = 2.5

#Camera stuff
var mouse_sensitivity = 0.3
var timer_started = false
@onready var head: Node3D = $Head
@onready var on_foot_camera: Camera3D = $Head/OnFootCamera

#Detection
@onready var nearby_check: Area3D = $NearbyCheck
@onready var ray: RayCast3D = $Head/OnFootCamera/RayCast3D
#Audio
@onready var walking_on_gravel: AudioStreamPlayer = $WalkingOnGravel
@onready var outside_ambience: AudioStreamPlayer = $OutsideAmbience

#axe
var axe_swinging = false

#flashlight
@onready var flashlight: Node3D = $Head/OnFootCamera/Flashlight

#Headbob
var BOB_FREQ: float = 3
const RUN_FREQ: float = 3
const WALK_FREQ: float = 5
var BOB_AMP: float = 0.05
const RUN_AMP: float = 0.05
const WALK_AMP: float = 0.025
var t_bob:float = 0.0

func _ready():
	if !Global.in_tutorial: 
		Global.OnFoot = false
		Global.JustSwitched = true
		switch_timer()
		
		
	Input.set_mouse_mode(Input.MOUSE_MODE_CAPTURED)
	set_as_top_level(true)
	

func switch_timer():
	if !timer_started:
		timer_started = true
		if Global.OnFoot: get_out_car()
		await get_tree().create_timer(.05).timeout
		timer_started = false
		Global.JustSwitched = false

func check_scene():
	if str(get_parent().name) == "GarageTest":
		Global.in_tutorial = true
	else: Global.in_tutorial = false
	if !Global.in_tutorial: Global.tutorial_done = true
	if Global.tutorial_done: Global.tutorial_num = 13

func get_out_car():
	global_position = Global.PlayerMarker

func inventory():
	#later add all other possible items with or 
	if Global.HasAxe or Global.HasExtraTire or Global.HasCarJack or Global.HasPoppedTire:
		Global.HasItem = true
	else:
		Global.HasItem = false

func check_nearby():
	var area_list = nearby_check.get_overlapping_areas()
	#Checks if player is nearby
	if nearby_check.has_overlapping_areas():
		var just_grab_range = false
		var just_place_range = false
		var just_opener_range = false
		for area in area_list:
			if area is PickUp:
				Global.NearPickup = true
				just_grab_range = true
			if area is PlaceZone or MultiPlaceZone:
				Global.NearPlaceZone = true
				just_place_range = true
			if area.is_in_group("OpenerAOE"):
				Global.NearGarageOpener = true
				just_opener_range = true
			else:
				if !just_grab_range: Global.NearPickup = false
				if !just_place_range: Global.NearPlaceZone = false
				if !just_opener_range: Global.NearGarageOpener = false
	if Global.NearPlaceZone: Global.ClosestDistance = 100.0
	

func _physics_process(delta: float) -> void:
	inventory()
	check_nearby()
	check_scene()
	#Switching
	if Global.JustSwitched: switch_timer()
	if Global.OnFoot:
		Global.PlayerPosition = global_position
		if !outside_ambience.playing: outside_ambience.play()
		#can you enter the car
		if !Global.JustSwitched and Input.is_action_just_pressed("Interact") and Global.NearDoor and !Global.HasItem:
			if Global.tutorial_num == 9: Global.CurrentCheck = true
			Global.NearDoor = false
			Global.OnFoot = false
			Global.JustSwitched = true
		#Camera
		on_foot_camera.make_current()
		
		#running
		if Input.is_action_pressed("Sprint"):
			BOB_FREQ = RUN_FREQ
			BOB_AMP = RUN_AMP
			SPEED = RUN_SPEED
			walking_on_gravel.volume_db = 0.0
		else: 
			BOB_FREQ = WALK_FREQ
			BOB_AMP = WALK_AMP
			SPEED = WALK_SPEED
			walking_on_gravel.volume_db = -3.0
		

		
		
		#Interactables
		if Input.is_action_just_pressed("Interact"):
			print(str(ray.is_colliding()))
			if Global.NearPickup and !Global.HasItem:
				if on_foot_camera.is_position_in_frustum(Global.ObjectPosition):
					print(str(ray.get_collider()))
					Global.JustPickedUp = true
			elif Global.NearPlaceZone and Global.HasItem:
				if on_foot_camera.is_position_in_frustum(Global.PlaceZonePosition):
					Global.JustPlaced = true	
			elif Global.HasAxe and !Global.AxeSwing:
				Global.AxeSwing = true
				axe_swinging = true
				AxeTimer()
			elif !Global.HasItem and Global.NearGarageOpener:
				print("test")
				if ray.is_colliding():
					print(str(ray.get_collider()))
					Global.GarageOpen = true
		
		#Flashlight
		if Input.is_action_just_pressed("ToggleLight"):
			Global.FlashOn = !Global.FlashOn
		if Global.FlashOn:
			flashlight.show()
		else:
			flashlight.hide()
		# Add the gravity.
		if not is_on_floor():
			velocity += get_gravity() * delta

		# Handle jump.
		if Input.is_action_just_pressed("ui_accept") and is_on_floor():
			velocity.y = JUMP_VELOCITY

		# Get the input direction and handle the movement/deceleration.
		# As good practice, you should replace UI actions with custom gameplay actions.
		var input_dir := Input.get_vector("Left", "Right", "Forward", "Backward")
		var direction := (transform.basis * Vector3(input_dir.x, 0, input_dir.y)).normalized()
		if direction:
			#Walking Audio
			if !walking_on_gravel.playing:
				walking_on_gravel.play()
			velocity.x = direction.x * SPEED
			velocity.z = direction.z * SPEED
		else:
			walking_on_gravel.stop()
			velocity.x = move_toward(velocity.x, 0, SPEED)
			velocity.z = move_toward(velocity.z, 0, SPEED)
		
		#Head bob
		t_bob += delta * velocity.length() * float(is_on_floor())
		on_foot_camera.transform.origin = _headbob(t_bob)
		
		
		move_and_slide()
	else: 
		walking_on_gravel.stop() 
		outside_ambience.stop()


func _headbob(time) -> Vector3:
	var pos = Vector3.ZERO
	pos.y = sin(time * BOB_FREQ) * BOB_AMP
	return pos

func AxeTimer():
	if axe_swinging:
		axe_swinging = false
		await get_tree().create_timer(.5).timeout
		print("test3")
		Global.AxeSwing = false
	
func _input(event):
	if event is InputEventMouseMotion:
		rotation_degrees.y -= event.relative.x * mouse_sensitivity
		head.rotation_degrees.x -= event.relative.y * mouse_sensitivity
		head.rotation_degrees.x = clampf(head.rotation_degrees.x,-70,90)
